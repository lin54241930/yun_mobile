# yun_mobile

### 前言（废话）

> 在使用Tcloud的初期，想的是搭建一套可以使用云真机的平台，因为STF界面不是很好看，且账号系统等不方便修改（自己太菜了），后续就开始着手Tcloud的搭建，但是在搭建过程中遇到很多的问题，从什么都不懂的小白，变成懂一点搭建的小白，再到后面可以自己改改东西的小白，期间学到了很多东西，还是很感谢作者，一直都想着把这套东西弄出来，一直都没什么时间，最近恰巧在整理文档之类的东西，就拉取了作者的源代码和STF官方最新的源代码，合在一起，加上自己的修改，让项目搭建好就可以直接使用

### 代码来源（觉得可以记得给作者的项目点点小星星，ps：也可以给我点个小星星）

- [STF](https://github.com/DeviceFarmer/stf)

- [Tcloud](https://github.com/JunManYuanLong/Tcloud)

- [TcloudServer](https://github.com/JunManYuanLong/TcloudServer)

因为集成的是官方的STF，所以没有支持IOS，如果需要请至下面链接

- [STF_IOS](https://github.com/mrx1203/stf)

请自行修改，STF详细修改见链接：[STF修改项](https://github.com/lin54241930/yun_mobile/blob/main/doc/STF%E4%BF%AE%E6%94%B9%E9%A1%B9.md)

### 本地部署STF

> 其实STF可以使用docker部署，那样步骤要少很多，不过如果需要二次开发，建议本地部署，这里只提供本地部署的方法，docker部署可自行百度

因为部署的步骤很多，所有部署方法详情请查看文档

- [Linux上STF部署](https://github.com/lin54241930/yun_mobile/blob/main/doc/STF%E9%83%A8%E7%BD%B2.xmind)
- [Mac上STF部署](https://github.com/lin54241930/yun_mobile/blob/main/doc/Mac%E4%B8%8A%E9%83%A8%E7%BD%B2STF.md)
- [Windows上STF部署](https://github.com/lin54241930/yun_mobile/blob/main/doc/Windows%E4%B8%8A%E9%83%A8%E7%BD%B2STF.md)

### 配置aapt和adb
- 配置`adb`（STF配置的教程中也有这个的详细教程）

  解压项目目录中`/tools/platform-tools.zip`文件至`/usr/local/`

  `vim /etc/profile`添加一行在最低部` export PATH=$PATH:/usr/local/platform-tools`

  再执行`source /etc/profile`

- 配置`aapt`（如果不配置这个，传包至服务器上，解析包会失败，包名和版本号等信息就无法写入到数据库中）

  同配置`adb`一样，先解压`/tools/build-tools.zip`文件至`/user/local/`

  `vim /etc/profile`添加一行在最低部` export PATH=$PATH:/usr/local/build-tools/30.0.3`

  再执行`source /etc/profile`

### Tcloud前端部署

- 需要准备的环境

  ``` NodeJs```

- 修改配置项

  找到 `Tcloud/config/dev.env.js `，修改完成后修改 `Tcloud/config/prod.env.js `

  同理，` prod.env.js` 是打包发布的配置，也就是生产环境下的配置，可自行更改生产环境的IP

```javascript
'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  // 接口地址配置
  // 修改这里的配置为后端接口的配置
  BASE_URL: '"http://192.168.1.2:9000"',
  //ws 服务的地址配置
  WS_BASE_URL:'"ws://xxxx"',
  //cookie 的过期时间
  COOKIE_EXPIRED: 14,
  //cookie 域名
  // 修改这里的IP为启动前端的服务器IP
  COOKIE_DOMAIN: '"192.168.1.2"',
  //cookie 存储前缀
  COOKIE_SUFFIX: '"_TCLOUD_DEV"',
  //企业微信扫码登录的相关配置
  QYWX_APPID: '"xxxx"',
  QYWX_AGENTID: '"xxxx"',
  QYEX_REDIRECT_URI: '"xxxx"',
  // 修改这里的地址为STF的地址，如果没有先配置好STF可以先配置上，后续再改
  STF_URL:'"http://192.168.1.2:7100"',
  // 修改这里的地址为后端服务器IP:9042这里是为了修改OSS为本地存储而添加的一个接口
  LOCAL_FILE_HOST:'"http://192.168.1.2:9042"'
})

```

### TcloudServer后端部署

> 后端部署分为docker部署和本地部署，docker部署虽较为方便，但是不方便二次开发
>
> 且作者的`docker-commpose.yml`文件许久都没有更新了，部署的话可能需要自己改改
>
> Ps:（我也懒，不想折腾docker了）
>
> 综上所诉还是建议本地部署，这里就不介绍docker的部署方法了，作者的文档中有详细的部署方法

- 需要准备的环境

  `Nginx`

  `Python3.7`及以上版本

  `MySQL`

- 安装Python依赖

  后端部署的坑在于` pip install` 安装Python依赖，这里会有些坑，不过我都修改了` requirement.txt`里面的内容了

  现在唯一的难点就在于安装`mysqlclient`

  在`Mac`上安装问题不是很大，配置好`MySQL`后，安装下`mariadb`就基本上可以解决问题

  但在`Linux`上可能会遇到问题多一点，这里先放一个`Linux`上`MySQL`的安装方法

  [Linux上安装MySQL](https://github.com/lin54241930/yun_mobile/blob/main/doc/CentOS7%E5%AE%89%E8%A3%85MySQL8.0.pdf)

- 配置数据库

  找到`/TcloudServer/local_config.py`修改数据库配置

```python
# SQL 连接字符串
SQLALCHEMY_DATABASE_URI = 'mysql://<username>:<password>@<host>:<port>/<db>?charset=utf8'
# 举个🌰
SQLALCHEMY_DATABASE_URI = 'mysql:/root:tc123456@192.168.1.2:3306/demo?charset=utf8'
```

- 初始化数据库

  找到数据库init文件` /TcloudServer/deploy/init/init.sql`

  用`Navicat`或其他数据库可视化软件执行`init.sql`文件即可

- 修改数据库中表`config`的`stf`的配置

  执行查询语句

  ```sql
  SELECT * FROM config WHERE module = 'stf'
  ```

  修改查询出来的三个数据里面字段`content`中的值

  修改`192.168.1.2:7100`为自己STF的地址

  修改`bearer`后面的`token`，这里的`token`可在`STF`中获取，地址为`http://IP:7100/#!/settings`生成访问令牌

  ```
  {"URL":"http://192.168.1.2:7100/api/v1/devices","headers":{"Authorization": "Bearer 60c67b9246bc45c6922c3b302be48809eb57f647eff647059ce56773d963060c"}}
  ```

  ```
  {"URL":"http://192.168.1.2:7100/auth/api/v1/url","headers":{"Authorization": "Bearer 60c67b9246bc45c6922c3b302be48809eb57f647eff647059ce56773d963060c"}}
  ```

  ```
  {"URL":"http://192.168.1.2:7100/api/v1/user/devices/","headers":{"Authorization": "Bearer 60c67b9246bc45c6922c3b302be48809eb57f647eff647059ce56773d963060c"}}
  ```



- 找到`/TcloudServer/local_config.py`修改存储文件到本地的地址和本地接口，这里的接口地址是为了获取本地图片

```python
# 本地接口地址
LOCAL_URL = 'http://192.168.1.2:9000'

# 储存文件到本地的地址
LOCAL_FOLDER = r'/usr/local/Tcloudfile'
```

- 配置`Nginx`

  我在作者原基础上加了个9044端口，因为下载文件需要用到这个

```
server {
    listen 9000;
    server_name 127.0.0.1 localhost;

  location /v1/datashow/ {
        proxy_pass http://127.0.0.1:9022;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }
    location /v1/jobs/ {
        proxy_pass http://127.0.0.1:9038;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }
       location /v1/message/ {
        proxy_pass http://127.0.0.1:9030;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location /v1/tcdevices/ {
        proxy_pass http://127.0.0.1:9036;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location  /v1/public/ {
        proxy_pass http://127.0.0.1:9034;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location  /v1/monkey/ {
        proxy_pass http://127.0.0.1:9022;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location ~* /v1/(flow|deploy)/ {
        proxy_pass http://127.0.0.1:9026;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location ~* /v1/(cidata|tool)/ {
        proxy_pass http://127.0.0.1:9024;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location ~* /v1/interface.* {
        proxy_pass http://127.0.0.1:9028;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location ~* /v1/(user|track|role|ability|feedback|wxlogin)/ {
        proxy_pass http://127.0.0.1:9020;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

    location / {
        proxy_pass http://127.0.0.1:9032;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }
    
    location ~* /v1/(getfile|getimage|defaultimage)/ {
        proxy_pass http://127.0.0.1:9044;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, projectid';
        add_header 'Access-Control-Allow-Methods' 'POST, GET, DELETE, OPTIONS';

    }

}
```
### 启动rethinkdb
- 直接输入`rethinkdb`启动，占用80端口
- 指定端口启动`rethinkdb --bind all --cache-size 8192 --http-port 8090`

### 启动STF

`cd`到`stf/bin`目录下

这里的`192.168.1.2`是我本地的IP，换成你自己的IP

```
./stf local --public-ip 192.168.1.2 --allow-remote
```

### 启动`Tcloud`前端

`cd`到`Tcloud/`目录下

```
npm run dev
```

### 启动TcloudServer后端

`cd`到`TcloudServer/`目录下

- `Linux`上可以一键启动，如报错没有logs目录，可手动创建`logs`目录后再执行

```
./start.sh
```

- `Mac`上不能一键启动，有两种办法

  一种是通过`Pycharm`工具一个一个右键`run`启动

  一种就是一个窗口一个窗口单独启动

  这里只介绍用命令启动的办法

```
python -m apps.auth.run
python -m apps.autotest.run
python -m apps.dowloadfile.run
python -m apps.extention.run
...
以此类推，需要启动apps目录下所有的服务，总共13个
```
### 配置手机图片
- 将图片上传至OSS或本地，得到图片地址后，手动配置`tc_devicesn_info`表中`pic`字段的值
- 如需图片请自行寻找，涉及到版权问题暂不提供

### 致谢

- [Tcloud](https://github.com/JunManYuanLong/TcloudServer) ：感谢作者提供源代码支持
- [stf](https://github.com/mrx1203/stf) : 感谢mrx1203提供的stf_ios方案
- [DeviceFarmerstf](https://github.com/DeviceFarmer/stf) : 感谢stf作者提供源代码支持
- [免登陆方案](https://blog.csdn.net/chuowan2555/article/details/100768165) : 感谢文章作者提供免登陆方案
- [Centos7安装MySQL8.0](https://www.cnblogs.com/yanglang/p/10782941.html) : 感谢文章作者提供安装思路