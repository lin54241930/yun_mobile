### 前言

> 平台原版本是用的oss做的文件的存储，后期使用下来发现流量开销有点大（因为都是在实验阶段，没有向公司申请oss），再后来想统一各个项目组传包方式，所以就不得不使用本地服务器做文件存储了，就想改造一下原平台的oss为本地存储，记录下改造的过程，可能代码和实现的方式有些粗糙，大佬见谅😁
>
> *修改思路其实很简单，就是将oss地址换成我们自己服务器地址，后端接受前端传过来的文件并保存到指定路径下（所有修改都在本地部署的前提下，如果是docker部署，修改其实都差不多，只是需要自己去改kong配置，不过既然都要自己二次开发了，还是墙裂推荐本地部署，搭配上Pycharm食用更佳）*

***

### 前端改造

#### element-upload组件

老规矩，先放上官方文档 [element-upload](https://element.eleme.cn/#/zh-CN/component/upload) 先去了解下官方的文档，知道组件怎么使用的，改起来也就知道怎么改了

*PS：如果对Vue不熟悉的同学，建议还是先去补一下Vue，这样后面改起来也会顺利得很多，磨刀不误砍柴工*

根据官方文档描述 ``` action ``` 这个参数为上传的地址，原平台中，这个地址是配置的oss地址，我们可通过前端

 ``` src/pages/autotest/common/FileUpload.vue ``` 这个子组件中查看 ```:action="ossData.host"``` 这里的 ``` ossData.host ```

是由父组件传递过来的，  ``` FileUpload ``` 的父组件位置在  ``` src/pages/autotest/components/UploadApk.vue ``` 

既然要将oss地址换成我们自己服务器的地址，那自然是改掉这个由父组件传递过来的 ``` ossData.host ``` 

来到我们的 ``` UploadApk.vue ``` 文件中找到引用子组件的地方

```vue
    <ArrowContainer head-text="上传安装包">
      <div slot="content">
        <el-tabs v-model="activeNameUpload">
          <el-tab-pane label="上传安装包" name="upload">
            <FileUpload
              v-if="ossData.hasOwnProperty('host')"
              :ossData="ossData"             # 将这个替换成服务器地址
              v-model="uploadFiles"
              @uploadUrl="uploadUrl"
            ></FileUpload>
          </el-tab-pane>
        </el-tabs>
      </div>
    </ArrowContainer>
```

当然，我们不能这么粗暴的直接修改``` :ossData="ossData" ``` 后面的 ``` ossData ``` 

万一后期想换一下服务器地址呢，万一要区分下测试服和正式服的地址呢，每次都改这里多麻烦

所以还是在源代码的基础上改 ```ossData ``` 这个计算属性，来到 ```computed ``` 下

```javascript
  computed: {
    ...mapState("autotest", ["selectApk"]),
    ossData() {
      return (process.env.LOCAL_FILE_HOST) + "/v1/upfile/pushfile";      // 修改这里，返回服务器地址
    },
    userId() {
      return this.$store.state.login.userid;
    }
  },
```

这里``` process.env.LOCAL_FILE_HOST```使用的```config```中的配置值，这样便可以实现正式服和测试服区别了

``LOCAL_FILE_HOST`` 需要在`config`中单独配置，`dev.env.js`和`prod.env.js`都需要配置

分别对应测试服和正式服的地址，下面例子是 `dev.env.js`另一个 `prod.env.js`同理（修改了配置要生效需要重启前端）

```javascript
'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  // 接口地址配置
  BASE_URL: '"http://192.168.31.214:8088"',
  //ws 服务的地址配置
  WS_BASE_URL:'"ws://xxxx"',
  //cookie 的过期时间
  COOKIE_EXPIRED: 14,
  //cookie 域名
  COOKIE_DOMAIN: '"192.168.31.214"',
  //cookie 存储前缀
  COOKIE_SUFFIX: '"_TCLOUD_DEV"',
  //企业微信扫码登录的相关配置
  QYWX_APPID: '"xxxx"',
  QYWX_AGENTID: '"xxxx"',
  QYEX_REDIRECT_URI: '"xxxx"',
  STF_URL:'"http://192.168.31.214:7100"',
  LOCAL_FILE_HOST:'"http://192.168.31.214:9042"'   // 这里的端口9042是后端新建的服务，后面会详细讲到
})
```

 如果前端我们只改这些肯定是不行的，因为原子组件从前端获取到`ossData`是一个对象

我们修改后就就变成了一个字符串了，子组件肯定会报错 ```:action="ossData.host"``` 是用的`ossData`中`host`这个对象

但是我们的字符串并不是对象，所以这里需要直接修改成`ossData` 同样我们还需要修改`props`中的`ossData`的类型为`String`

```javascript
props: {
    value: {
      type: Array,
      default() {
        return [];
      }
    },
    ossData: {
      type: String    //修改这里为String
    },
    readOnly: {
      type: Boolean,
      default() {
        return false;
      }
    }
  },
```

注释掉计算属性`computed`，计算属性中还是带有对象`ossData`中的一些属性

我们传过来的字符串不具备这些，简单粗暴一点，直接注释掉

修改上传成功回调，文件上传之前的钩子和文件上传的钩子

```javascript
 // 上传成功的回调
    handleSuccess(response, file, fileList) {
      console.log("success", response);
      //file.url = `${this.ossData.cdn_host}/${this.uploadParams.key}`;
      // 这里的地址为后端获取本地文件的地址，后面的后端改造会讲到
      file.url = (process.env.BASE_URL) + "/v1/getfile/" + (file.name);
      //this.uploadfiles.push(file);
      this.fileFlag = false;
      this.isShowUploadfile = true;
      //this.$emit("input", this.uploadfiles);
      // 调用接口，将url传给后台
      this.$emit('uploadUrl', file)
    },
 ..........
     // 文件上传之前的钩子
    handleBeforeUpload(file) {
      // 校验上传的是否是apk包
      console.log("beforupload", file);
      let fileNameSplit = file.name.split(".");
      let fileSuffix = fileNameSplit[fileNameSplit.length - 1];
      if (fileSuffix === "apk") {
        // this.uploadParams.key = `${
          // this.ossData.dir
        // }${generateUUID()}${getSuffix(file.name)}`;    //  屏蔽这里还是因为原ossData的数据原因
        this.isShowUploadfile = false;
      } else {
        this.$message.warning('暂时只支持android包上传')
        return false
      }
    },
    // 文件上传的钩子
    handlerUploadProcess(event, file, fileList) {
      this.fileFlag = true;
      var i = 0
      for (i in fileList){
        this.fileUploadPercent = file.percentage.toFixed(0) * 1;
      }
    }

```

上传成功的回调很重要，关系到上传成功后是否能显示

这里需要在新增一个后端的服务，用来解析上传到服务器上的文件，下面的服务端改造会讲到

前端的改造很少，基本上就这些，主要还是修改`element-upload`组件的`action`的值

修改`element-upload`组件上传的钩子，成功回调这些，放一个我修改后的`FileUpload.vue`吧

```vue
<template>
  <div>
    <el-upload class="upload-box" drag multiple :action="ossData" list-type="text" :on-remove="handleRemove"
      :on-success="handleSuccess" :on-error="handleUploadError" :on-exceed="handleExceed"
      :before-upload="handleBeforeUpload" :on-progress="handlerUploadProcess" :on-preview="handleFilePreview"
      :data="uploadParams" :limit="10" :fileList="uploadfiles" :disabled="readOnly">
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">
        <p style="font-size: 16px;">
          将文件拖到此处，或
          <em>点击上传</em>
        </p>
        <p style="font-size: 14px; color: rgba(0,0,0,.45);">
          暂时只支持android包
          <br>请注意上传文件的格式与大小，避免上传出现问题
        </p>
      </div>
    </el-upload>
  </div>
</template>
<script>
  import {
    generateUUID,
    getSuffix
  } from "@/utils/util.js";
  export default {
    name: "imgUpload",
    props: {
      value: {
        type: Array,
        default () {
          return [];
        }
      },
      ossData: {
        type: String
      },
      readOnly: {
        type: Boolean,
        default () {
          return false;
        }
      }
    },
    data() {
      return {
        uploadfiles: this.value,
        loading: false,
        fileUploadPercent: 0,
        fileFlag: false,
        isShowUploadfile: true,
        filePreview: false,
        fileUrl: "",
        uploadParams: {},
        fileary: []
      };
    },
    watch: {
      value: {
        handler: function (cval) {
          this.uploadfiles = cval;
        },
        deep: true
      }
    },
    components: {},
    // computed: {
    //   uploadParams() {
    //     return {
    //       OSSAccessKeyId: this.ossData.accessid,
    //       policy: this.ossData.policy,
    //       signature: this.ossData.signature,
    //       key: `${this.ossData.dir}${this.filename}`,
    //       success_action_status: 200
    //     };
    //   }
    // },
    methods: {
      // 上传数量超过限制回调
      handleExceed(file, fileList) {
        this.$message.error("上传apk包数量超过上限");
      },
      // 上传失败的回调
      handleUploadError(error, file, fileList) {
        this.$message.error(error);
      },
      // 上传成功的回调
      handleSuccess(response, file, fileList) {
        console.log("success", fileList);
        file.url = (process.env.BASE_URL) + "/v1/getfile/" + (file.name);
        this.fileFlag = false;
        this.isShowUploadfile = true;
        // 调用接口，将url传给后台
        this.$emit('uploadUrl', file)
      },
      // 移除成功的回调
      handleRemove(file, fileList) {
        console.log("remove", file);
          if (this.uploadfiles.findIndex(item => item.uid === file.uid) !== -1) {
            this.uploadfiles.splice(this.uploadfiles.findIndex(item => item.uid === file.uid), 1);
          }
      },
      // 预览
      handleFilePreview(file) {
        window.open(file.url);
      },
      // 文件上传之前的钩子
      handleBeforeUpload(file) {
        // 校验上传的是否是apk包
        console.log("beforupload", file);
        let fileNameSplit = file.name.split(".");
        let fileSuffix = fileNameSplit[fileNameSplit.length - 1];
        if (fileSuffix === "apk") {
          // this.uploadParams = `${
          //   this.ossData.dir
          // }${generateUUID()}${getSuffix(file.name)}`;
          this.isShowUploadfile = false;
        } else {
          this.$message.warning('暂时只支持android包上传')
          return false
        }
      },
      // 文件上传的钩子
      handlerUploadProcess(event, file, fileList) {
        this.fileFlag = true;
        var i = 0
        for (i in fileList) {
          this.fileUploadPercent = fileList[i].percentage.toFixed(0) * 1;
          console.log(fileList[i])
        }
      }
    },
    created() {}
  };

</script>

<style lang="scss" scoped>
</style>

```

子组件修改了后别忘了修改父组件对应的地方

```vue
<!-- 原组件引用 -->
<ArrowContainer head-text="上传安装包">
      <div slot="content">
        <el-tabs v-model="activeNameUpload">
          <el-tab-pane label="上传安装包" name="upload">
            <FileUpload
              v-if="ossData.hasOwnProperty('host')"
              :ossData="ossData"
              v-model="uploadFiles"
              @uploadUrl="uploadUrl"
            ></FileUpload>
          </el-tab-pane>
        </el-tabs>
      </div>
    </ArrowContainer>
<!-- 修改后的引用对比 -->
<ArrowContainer head-text="上传安装包">
      <div slot="content">
        <FileUpload :ossData="ossData" v-model="uploadFiles" @uploadUrl="uploadUrl"></FileUpload>
      </div>
    </ArrowContainer>
<!-- 看得出来我这里去掉了v-if，因为修改后的ossData只是一个字符串，获取不到hasOwnProperty('host') -->
```

### 后端改造

#### Nginx

因为加了服务，所以还是需要去新加`Nginx`配置的

```
        location /v1/getfile/ {
            proxy_pass http://127.0.0.1:9044;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
            add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

        }
```

新加配置后记得`nginx -s reload`重启下

#### 添加新的服务

来到后端项目的文件夹下，在`apps`目录下新建一个目录，名字随意

PS：其实还有个较为懒的办法，就是复制一份tcdevices，然后再在里面修改，不过修改起来也是需要细心，不推荐这种方法

#### 上传文件的方法

我这里就新建一个`upfile`文件夹

PS：如果用的Pycharm就直接在`apps`目录右键`New`一个`Python Package`出来，这样就会自动生成`__init__.py`文件

其他的我就不一一写创建什么文件了，列一个目录树

下面中的代码用到了`local_config.py`中的配置，所以需要先去配置`LOCAL_FOLDER`

`LOCAL_FOLDER = r'/Users/boke/TcServer/allfile'` 这里加了个`r`是因为在Windows下`\`会被转义，所以需要加个`r` 

```
├── upfile
|   ├── business
|   	└── __init__.py
|   	└── upfile.py
|		├── settings
│   	└── __init__.py
│   	└── config.py
|		├── views
│   	└── __init__.py
│   	└── upfile.py
│   └── __init__.py        
|   └── run.py           			
```

代码都很简单，我依次放下代码

`business > upfile.py`

```python
import os
import traceback
from flask import request, g, current_app
from public_config import LOCAL_FOLDER
# 这里的LOCAL_FOLDER是在public_config中配置的，需要自行配置


class GetUploadFile(object):
    @classmethod
    def getfile(cls):
        if os.path.exists(LOCAL_FOLDER):
            try:
                if request.method == 'POST':
                    f = request.files['file']
                    file_path = os.path.join(LOCAL_FOLDER, f.filename)
                    f.save(file_path)
                    return print(f.filename)
            except Exception as e:
                current_app.logger.error(e)
                current_app.logger.error(traceback.format_exc())
                return []
        else:
            os.makedirs(LOCAL_FOLDER)
            return cls.getfile()
```

`settings > config.py`

```python
try:
    from public_config import *
except ImportError:
    pass

PORT = 9042
SERVICE_NAME = 'upfile'

```

`views > upfile.py`

```python
from flask import Blueprint
from apps.upfile.business.upfile import GetUploadFile

upfile = Blueprint("upfile", __name__)


@upfile.route('/pushfile', methods=['POST'])
def pmreport_cont():

    response = {
        "code": 0,
        "data": GetUploadFile.getfile()
    }

    return response
```

`run.py`

```python
from apps.upfile.settings import config
from flask_cors import CORS    # 这里用到了CORS，不然会出现跨域问题
if config.SERVER_ENV != 'dev':
    from gevent import monkey

    monkey.patch_all()
else:
    pass

from apps.upfile.views.upfile import upfile
from library.api.tFlask import tflask


def create_app():
    app = tflask(config)
    register_blueprints(app)
    CORS(app, supports_credentials=True)
    return app


def register_blueprints(app):
    app.register_blueprint(upfile, url_prefix="/v1/upfile")


if __name__ == '__main__':
    create_app().run(port=config.PORT)

```

#### 下载文件的方法

下载文件的方法很简单，如上步骤，建一个`downloadfile`目录（`__init__.py`文件是必须的）

```
├── downloadfile
│   └── __init__.py        
|   └── run.py          
```

`run.py`

```python
import os
from flask import Flask, send_file, send_from_directory
from public_config import LOCAL_FOLDER
# 同样，这里的LOCAL_FILDER还是那个

app = Flask(__name__)  # 实例化flask app


# filename是客户端传来的需要下载的文件名
@app.route('/v1/getfile/<filename>', methods=['GET'])
def get_file(filename):
    file_path = os.path.join(LOCAL_FOLDER, filename)
    print(file_path)
    if os.path.isfile(file_path):
        print(file_path)
        return send_file(file_path, as_attachment=True)
    else:
        return "The downloaded file does not exist"


if __name__ == '__main__':
    app.run(debug=True, port=9044)
```

上传文件的端口是9042，下载文件的端口是9044，其实是可以集成到一个端口上的

我这样还开两个端口，有些浪费了

不过在弄前端的时候懒得搞`element-upfile` 的`http-request`自定义上传的实现

如果用自定义上传的话，弄成一个端口应该是没毛病的

遇到的问题就是，如果我写成一个端口，下载文件就会出问题，因为后端加了`CORS`，相当于没有走`Nginx`

如果去掉`CORS`，上传文件又会被跨域拦截，前端上传是直接通过定义的地址请求的，没有通过`axiox`来请求

可能还是因为上传文件不是自定义`http-request`的实现方式吧

如果有大佬有更好的方法，也欢迎修改

以上就是修改的内容了，都是靠着自己的回忆来写的，也可能还改了什么其他的东西没写上

可能会有错误的地方，有错的地方再提醒我改下吧

PS：我也是小白，欢迎大佬们指正

