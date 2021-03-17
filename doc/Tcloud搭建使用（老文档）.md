## 搭建

------

Tcloud是前后端分离的项目，所以搭建分前端和后端

Ps：（项目文档中有搭建方法，本文只是讲述自己在搭建过程中遇到的问题，本人也是小白，看到不对的地方请指教）

[前端传送门](https://github.com/JunManYuanLong/Tcloud)

[后端传送门](https://github.com/JunManYuanLong/TcloudServer)

#### 一、前端

前端搭建很简单只需要自己配好node环境，代码clone下来，cd到项目根目录` npm install`就行了

其实在搭建Tcloud的之前就应该先搭建好STF，搭建STF需要` node version < 9` 

作者也没要求一定要多少版本的，自己搭建使用的版本为`node version = v8.9.3`

#### 二、后端

搭建好前端后不用忙着先启动，接下来开始搭建后端

作者提供了两种后端的搭建方法，一种是`docker`搭建，一种是本地搭建

个人使用的是本地搭建，之前因为在使用`docker`搭建的时候遇到了一些坑加上自己也想二次开发，选择了本地搭建

ps:（其实本地搭建挺简单的，就只是在新电脑上安装配置数据库，安装pip包这些地方会遇到一些坑）

先讲讲本地搭建吧，自己本地搭建时使用的Mac

##### 1.本地搭建

本地搭建方便随时对某个服务的启停，在`Pycharm`上可以更好的二次开发，随时调试

搭建前需要准备的东西：`MySQL`、`Python=>3.7`、`Nginx`

`MySQL`：安装`MySQL`网上都有很多教程，Mac上安装也比较方便，自己没有使用`brew`安装，去官网上直接下的dmg安装包

`Python`：同理，安装起来也比较方便，注意安装版本即可，Mac自带`Python2.6`所以直接去`Python`官网上下载一个dmg安装包安装即可

`Nginx`：这里安装的时候使用的`brew`，Mac上`brew`使用起来很方便，缺啥直接`brew install xxx` 即可`brew install nginx`后便可使用

##### Step 1：clone代码到本地

`git clone https://github.com/JunManYuanLong/TcloudServer`

##### Step 2：安装pip包

cd到`clone`下来的文件夹下，`pip install -r requirement.txt`

ps：注意这里的pip版本`pip --version`如果指向的是`Python2`则使用`pip3 --version`查看指向的是否是`Python3`

如果是那安装pip包的时候则需要使用`pip3 install -r requirement.txt`

安装速度慢可以考虑使用其他源，例如：`pip install -r requirement.txt -i https://mirrors.aliyun.com/pypi/simple`

自己使用Mac安装途中会遇到一些`mysqlclient`的一些问题

例如：`OSError: mysql_config not found`，这里先检查下`MySQL`是否配置好了环境变量`mysql --version`

如果出现了未找到命令等提示的话，就需要先去配置下`MySQL`的环境变量，网上有很多可以自行百度

配置好了后再次安装pip包，如果还是报和`mysql`有关的问题的话，再装一下`mariadb`用`brew`装就行`brew install mariadb`

##### Step 3：配置`Nginx`

Mac上的`Nginx`配置文件路径在`/usr/local/etc/nginx/nginx.conf`改成如下地址即可

[配置Nginx](https://github.com/JunManYuanLong/TcloudServer/blob/master/deploy/docs/快速安装.md#二配置nginx)

配置这个的时候要注意`server_name`地址如果后端和前端部署在一台电脑上，可以不用改`localhost`

如果是分开部署的，这里需要配置成当前的IP，改的这个地址就是接口地址，端口就是`listen`后面的那个

后面在前端配置的时候需要将这个地址配置到接口地址那里

##### Step 4：启动服务

**Linux：**启动很简单，上面的配置好了后，cd到TcloudServer目录中`./start.sh`即可，**注意这里有坑**：启动脚本中是用的`python`启动的

如果本地同时有`python2` `python3`就需要看下`python --verison`是什么版本了,如果输出的版本是`python3`则无需修改，如果输出的版本是` python2` 

 则需要修改`start.sh`脚本中的`python`版本，因为 `TcloudServer`的服务需要`python3`来启动，且最好是大于3.7

```python
start_apps(){
    echo Start all apps of tcloud !
    for key in ${!map[@]} ;
    do
        echo start $key : ${map[$key]}
        nohup python  -m apps.$key.run >logs/$key.log 2>&1 &  #如果自己使用python3 --version输出的才是python3的话，
  																														#那这里的python就需要改为python3
    done
}
```

**Mac：**因为不能使用那个自带的脚本启动，所以就一个一个的服务启动吧

如果Mac上有`Pycharm`（`Pycharm`真心好使，如果要二次开发的话，有这个会事半功倍）直接打开TcloudServer项目，去一个一个启动

apps目录下的每个文件夹中都有一个`run.py`，一个一个的右键运行即可

app文件夹下每一个文件夹都是一个服务，需要什么服务就启动什么服务就行，当然有些服务是公有的，不清楚的话就全部启动吧

当然还可以使用命令启动，`python -m apps.auth.run` ，同样这里也需要注意`python`版本，注意使用`python3`启动

查看python版本同上Linux的方法，这里的启动命令需要cd到TcloudServer文件夹下

命令中的`apps`代表的是apps文件夹 ，auth代表的每个服务的名字，也就是apps文件夹下的文件夹，依然需要一个一个启动

启动后命令窗口不要关，开一个新窗口再启动下一个服务

Ps：其实可以用nohup启动`nohup python3 -m apps.auth.run > logs/auth.log 2>&1 & `

这样可以用一个命令窗口去启动所有服务了

启动好了后就可以接着启动下一个服务，不用开新窗口

但是在调试阶段的话还是建议不用nohup启动因为查看日志还是需要到log目录下查看，不方便实时查看报错等信息



## 配置

------

搭建好了后就是配置了，配置其实也不是很多，只是要想用到一些功能的话，还是需要单独配置

##### Step 1：前端配置

前端配置很少，只需要配置好后端地址和STF地址就行

##### Step 2：后端配置

如果需要用到后面的monkey的功能的话，就需要配置一下OSS了，[配置OSS的帖子](https://testerhome.com/topics/21213)

##### Step 3：数据库配置

![配置图](https://github.com/lin54241930/yun_mobile/blob/main/doc/config%E8%A1%A8%E4%B8%ADstf%E7%9A%84%E9%85%8D%E7%BD%AE.png)

很多问题会出在配置数据库这里，因为这里是配置的STF地址和token的一些东西，配错了的话，在云真机里面就会显示不出设备或者是不能正常跳转至STF中

配置的格式为`{"URL":"http://192.168.1.120:7100/api/v1/devices","headers":{"Authorization": "Bearer 60c67b9246bc45c6922c3b302be48809eb57f647eff647059ce56773d963060c"}}` IP那里是装有STF那台电脑的IP

后面的是一些STF提供的API接口，例如`/api/vi/devices`就是获取设备的api，第二个是我自己修改的一个api用来面登录STF（下面会降到如何修改）

Bearer后面就是token了，这里需要去STF中去获取这个，注意Bearer后面有空格

## 修改

------

其实这样像上面这样配置和启动服务后就能正常的登录进去了，但是还有一些东西我们需要修改一下

1.免登陆

- 免登陆最核心的就是改STF的登录接口，[修改免登陆的帖子](https://blog.csdn.net/chuowan2555/article/details/100768165)

- 修改后端`tcdevices.py`文件，文件路径`TcloudServer/apps/tcdevices/business/tcdevicces.py`

  找到方法`stf_token`

  ```python
      def stf_token(cls):
          name = request.args.get('name')
          stf_token = Config.query.add_columns(Config.content.label('content')).filter(
              Config.module == 'stf',
              Config.module_type == 2).first()
          stf_token = json.loads(stf_token.content)
          current_app.logger.info(json.dumps(stf_token, ensure_ascii=False))
          url = stf_token['URL'] + '?username=' + name   # 修改这里
          ret = requests.get(url)
          ret = json.loads(ret.content)
          current_app.logger.info(json.dumps(ret, ensure_ascii=False))
          return ret
  ```

- 修改前端`DeviceList.vue`、`usedevices.vue`文件，文件路径`Tcloud/src/page/stf`

  找到方法`toStfPage()`

  ```javascript
  toStfPage() {
        tcdevicesApi.getTcToken({ name: this.$store.getters.userName }).then(
          res => {
            this.token = res.data.data.token;
            // this.stfurl = `${process.env.STF_URL}?jwt=${this.token}`;
            this.stfurl =  res.data.data.url     //修改这里
             console.log(this.stfurl);
          },
          error => {
            this.$message.error(`获取设备token失败: ${error.message}`);
          }
        );
      }
  ```

  

2.修改切换平台为IOS后，不显示设备

这里的问题就是因为获取不到IOS设备的电量，所以会导致`item.battery.level`的值为空，这里没有做其他优化修改，直接屏蔽了

```javascript
          <ul class="card_info___17TpC">
            <li
              style="overflow:hidden;word-break: keep-all;white-space:nowrap;text-overflow:ellipsis;"
            >型号：{{item.model}}</li>
            <li>版本：{{item.version}}</li>
            <li
              v-if="item.display.height && item.display.width"
            >分辨率：{{item.display.height}}x{{item.display.width}}</li>
            <!-- <li v-if="item.battery.level">电量：{{item.battery.level}}%</li> -->    这里直接屏蔽了这个电量显示
            <li>使用次数：{{item.times}}</li>
            <li>累计使用：{{item.use_time}}分钟</li>
            <li>CPU：{{item.cpu}}</li>
            <li>ABI：{{item.abi}}</li>
          </ul>
```

我这里修改了一下手机的显示面板，可以根据各自需求增加一些

![效果图](https://github.com/lin54241930/yun_mobile/blob/main/doc/%E4%BA%91%E7%9C%9F%E6%9C%BA%E7%95%8C%E9%9D%A2%E6%95%88%E6%9E%9C%E5%9B%BE.png)

还有一些自己觉得不好的可以自行修改



## 修改STF

------

为了适配Tcloud而改了一些STF的界面显示，使之美观一点（自己也很菜懂得不多，只能小打小闹的修改一些，不对的地方，还请指正）

### 修改免登陆 

文件：`lib/units/auth/mock.js`
[修改文章](https://blog.csdn.net/chuowan2555/article/details/100768165)

```javascript
var http = require('http')

var express = require('express')
var validator = require('express-validator')
var cookieSession = require('cookie-session')
var bodyParser = require('body-parser')
var serveStatic = require('serve-static')
var csrf = require('csurf')
var Promise = require('bluebird')
var basicAuth = require('basic-auth')

var logger = require('../../util/logger')
var requtil = require('../../util/requtil')
var jwtutil = require('../../util/jwtutil')
var pathutil = require('../../util/pathutil')
var urlutil = require('../../util/urlutil')
var lifecycle = require('../../util/lifecycle')

const dbapi = require('../../db/api')

module.exports = function(options) {
  var log = logger.createLogger('auth-mock')
  var app = express()
  var server = Promise.promisifyAll(http.createServer(app))

  lifecycle.observe(function() {
    log.info('Waiting for client connections to end')
    return server.closeAsync()
      .catch(function() {
        // Okay
      })
  })

  // BasicAuth Middleware
  var basicAuthMiddleware = function(req, res, next) {
    function unauthorized(res) {
      res.set('WWW-Authenticate', 'Basic realm=Authorization Required')
      return res.send(401)
    }

    var user = basicAuth(req)

    if (!user || !user.name || !user.pass) {
      return unauthorized(res)
    }

    if (user.name === options.mock.basicAuth.username &&
        user.pass === options.mock.basicAuth.password) {
      return next()
    }
    else {
      return unauthorized(res)
    }
  }

  app.set('view engine', 'pug')
  app.set('views', pathutil.resource('auth/mock/views'))
  app.set('strict routing', true)
  app.set('case sensitive routing', true)

  app.use(cookieSession({
    name: options.ssid
  , keys: [options.secret]
  }))
  app.use(bodyParser.json())
  app.use(csrf())
  app.use(validator())
  app.use('/static/bower_components',
    serveStatic(pathutil.resource('bower_components')))
  app.use('/static/auth/mock', serveStatic(pathutil.resource('auth/mock')))

  app.use(function(req, res, next) {
    res.cookie('XSRF-TOKEN', req.csrfToken())
    next()
  })

  if (options.mock.useBasicAuth) {
    app.use(basicAuthMiddleware)
  }

  // app.get('/', function(req, res) {
  //   res.redirect('/auth/mock/')
  // })

  app.get('/auth/contact', function(req, res) {
    dbapi.getRootGroup().then(function(group) {
      res.status(200)
        .json({
          success: true
        , contact: group.owner
        })
    })
    .catch(function(err) {
      log.error('Unexpected error', err.stack)
      res.status(500)
        .json({
          success: false
        , error: 'ServerError'
        })
      })
  })
//页面请求为ip+端口/auth/mock/，打开登陆页面
  app.get('/auth/mock/', function(req, res) {
    res.render('index')
  })
  // 前端请求登陆接口，验证用户名密码是否正确
  app.post('/auth/api/v1/mock', function(req, res) {
    var log = logger.createLogger('auth-mock')
    log.setLocalIdentifier(req.ip)
    switch (req.accepts(['json'])) {
      case 'json':
        requtil.validate(req, function() {
            req.checkBody('name').notEmpty()
            req.checkBody('email').isEmail()
          })
          .then(function() {
            log.info('Authenticated "%s"', req.body.email)
            var token = jwtutil.encode({
              payload: {
                email: req.body.email
              , name: req.body.name
              }
            , secret: options.secret
            , header: {
                exp: Date.now() + 24 * 3600
              }
            })

            log.info('stf login token: ', urlutil.addParams(options.appUrl, {
              jwt: token
            }))
            res.status(200)
              .json({
                success: true
              , redirect: urlutil.addParams(options.appUrl, {
                  jwt: token
                })
              })
          })
          .catch(requtil.ValidationError, function(err) {
            res.status(400)
              .json({
                success: false
              , error: 'ValidationError'
              , validationErrors: err.errors
              })
          })
          .catch(function(err) {
            log.error('Unexpected error', err.stack)
            res.status(500)
              .json({
                success: false
              , error: 'ServerError'
              })
          })
        break
      default:
        res.send(406)
        break
    }
  })
  app.get('/auth/api/v1/url', function(req, res) {
    var log = logger.createLogger('auth-api-url')
    log.setLocalIdentifier(req.ip)
    var userName = req.query.username
    log.info('传入的username: ' + userName)
    if(userName) {
      var token = jwtutil.encode({
        payload: {
          email: userName + '@zbj.com'
          , name: userName
        }
        , secret: options.secret
        , header: {
          exp: Date.now() + 24 * 3600
        }
      })
      log.info('生成的token ' + token)
      var respStr = urlutil.addParams(options.appUrl, {
        jwt: token
      })
      log.warn('返回的登录地址 ' + respStr)
      // 渲染列表页面，支持跨域
      res.header('Access-Control-Allow-Origin', '*')
      res.jsonp({url: respStr})
    }
   else {
    res.status(400)
      .json({
        success: false
        , error: 'ValidationError'
        , validationErrors: err.errors
      })
      }
  })

  server.listen(options.port)
  log.info('Listening on port %d', options.port)
}
```

### 修复某些电脑上不能正常显示字体的问题

- [修复字体显示](https://testerhome.com/topics/14654)

1.  需要修改以下两个pug文件

- 文件： `res/auth/mock/views/index.pug` 中添加 `.defaultfontfamily` 样式

```jade
html(ng-app='app')
  head
    title STF
    base(href='/')
    meta(charset='utf-8')
    meta(name='viewport', content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui')
  body(ng-cloak).defaultfontfamily
    div(ng-view)
    script(src='static/app/build/entry/commons.entry.js')
    script(src='static/app/build/entry/authmock.entry.js')
```

- 文件： `res/app/views/index.pug` 中添加 `.defaultfontfamily` 样式

```jade
html(ng-app='app')
  head
    meta(charset='utf-8')
    base(href='/')
    meta(name='viewport', content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no')
    meta(name='mobile-web-app-capable', content='yes')
    meta(name='apple-mobile-web-app-capable', content='yes')
    meta(name='apple-mobile-web-app-title', content='STF')
    meta(name='format-detection', content='telephone=no')
    meta(name='apple-mobile-web-app-status-bar-style', content='black-translucent')
    link(href='static/logo/exports/STF-128.png', rel='apple-touch-icon')

    title(ng-bind='pageTitle ? "STF - " + pageTitle : "STF"') STF
  body(ng-cloak).bg-1.fill-height.unselectable.defaultfontfamily
    div(ng-controller='LayoutCtrl', basic-mode, admin-mode, standalone, landscape).fill-height
      .pane-top.fill-height(fa-pane)
        .pane-top-bar(fa-pane, pane-id='menu', pane-anchor='north',
          pane-size='{{!$root.basicMode && !$root.standalone ? 0 : 0 }}px',

          pane-handle='')
          div(ng-include='"menu.pug"')

        .pane-center(fa-pane, pane-id='main', pane-anchor='center').fill-height
          socket-state
          div(growl)
          div(ng-view).fill-height

    script(src='/app/api/v1/state.js')
    script(src='static/app/build/entry/commons.entry.js')
    script(src='static/app/build/entry/app.entry.js')
```

2. 需要在以下三个CSS文件中添加新样式(文件底部添加即可)

```css
.defaultfontfamily{
font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;}
```

- 文件：`res/auth/mock/scripts/signin/signin.css`
- 文件：`res/app/layout/stf-styles.css`
- 文件：`res/app/components/stf/common-ui/nothing-to-show/nothing-to-show.css`

### 修改界面

1. 修改logo

- 文件：`res/common/logo/exports/` 替换 `STF-128.png`、`STF-512.png` 其中 `STF-128.png` 为网页顶部标题的icon和控制设备界面左上角的logo `STF-512.png` 为登录页的logo

2. 屏蔽顶部的导航栏

- 文件：`res/app/views/index.pug` 中修改第18行代码 `pane-size='{{!$root.basicMode && !$root.standalone ? 0 : 0 }}px',` 这里的修改是为了将顶部留的空缩小至0，如果不需要屏蔽掉顶部导航栏，只需要屏蔽部分按钮，则不需要改这里
- 文件：`res/app/menu/index.js` 中屏蔽掉第五行中 `require('./menu.css')` 这里是屏蔽掉顶部导航栏的所有样式（此方式屏蔽后，可能会报错，不建议此方法屏蔽，直接将那个顶部空间缩小至0就行）
- 文件：`res/app/menu/menu.pug` 中可以选择性的屏蔽一些顶部导航栏按钮

3. 屏蔽控制设备右侧的一些按钮

- 文件：`res/app/control-panes/control-panes-controller.js` 中屏蔽数组中一整对值
  `例如：`

```javascript
     {
        title: gettext('Screenshots'),
        icon: 'fa-camera color-skyblue',
        templateUrl: 'control-panes/screenshots/screenshots.pug',
        filters: ['native', 'web']
      },
      // {
      //   title: gettext('Automation'),
      //   icon: 'fa-road color-lila',
      //   templateUrl: 'control-panes/automation/automation.pug',
      //   filters: ['native', 'web']
      // },
      // {
      //   title: gettext('Advanced'),
      //   icon: 'fa-bolt color-brown',
      //   templateUrl: 'control-panes/advanced/advanced.pug',
      //   filters: ['native', 'web']
      // },
      {
        title: gettext('File Explorer'),
        icon: 'fa-folder-open color-blue',
        templateUrl: 'control-panes/explorer/explorer.pug',
        filters: ['native', 'web']
      }
```

4. 调整底部日志框的默认大小

- 文件：`res/app/control-panes/control-panes.pug` 中修改第13行中的 `pane-size` 可自行调整百分百

5. 屏蔽或修改控制面板中的控件

- 文件：`res/app/control-panes/dashboard/dashboard.pug` 这里是用的是bootstrap的栅格系统，可自行调整所需控件的大小，或删除控件
  `例如：`

```jade
//- .row
//-   .col-md-6
//-     div(ng-include='"control-panes/dashboard/navigation/navigation.pug"')
//-   .col-md-6
//-     div(ng-include='"control-panes/dashboard/clipboard/clipboard.pug"')

.row
  .col-md-12
    div(ng-include='"control-panes/dashboard/install/install.pug"')
  //- .col-md-6(ng-if='$root.platform == "native"')
  //-   div(ng-include='"control-panes/dashboard/shell/shell.pug"')
.row
  .col-md-12
    div(ng-include='"control-panes/dashboard/apps/apps.pug"')
  //- .col-md-6
  //-   div(ng-include='"control-panes/advanced/remote-debug/remote-debug.pug"')
```

- 文件：`res/app/control-panes/dashboard/index.js` 如果屏蔽了一些控件，这里也需要相应的屏蔽掉(不屏蔽也没啥影响)
  `例如：`

```javascript
module.exports = angular.module('stf.dashboard', [
  // require('./navigation/index').name,
  // require('./shell/index').name,
  require('./install/index').name,
  require('./apps/index').name,
  // require('./clipboard/index').name,
  // require('./remote-debug/index').name
])
  .run(['$templateCache', function($templateCache) {
    $templateCache.put(
      'control-panes/dashboard/dashboard.pug'
      , require('./dashboard.pug')
    )
  }])
  .controller('DashboardCtrl', require('./dashboard-controller'))

```

6. 屏蔽应用程序控件中部分按钮

- 文件：`res/app/control-panes/dashboard/apps/apps.pug` 中屏蔽掉一整组 `button` 即可
  `例如：`

```jade
    button.btn.btn-primary-outline.icon-app.pull-right(ng-click='openSettings()')
      i.fa.fa-gear.fa-lg.color-darkgray
      .icon-title {{"Settings" | translate}}

    //- button.btn.btn-primary-outline.icon-app.pull-right(ng-click='control.openStore()').color-pink
    //-   i.fa.fa-shopping-cart.fa-lg.color-blue
    //-   .icon-title {{"App Store" | translate}}

  .widget-content.padded
    button.btn.btn-primary-outline.icon-app.pull-right(ng-click='openWiFiSettings()')
      i.fa.fa-wifi.fa-lg.color-skyblue
      .icon-title {{"WiFi" | translate}}
```

7. 修改断开连接时弹出的modal窗口显示

- 文件：`res/app/components/stf/common-ui/modals/fatal-message/fatal-message.pug` 可以屏蔽掉跳转设备按钮
  `例如：`

```jade
.stf-fatal-message.stf-modal
  .modal-header.dialog-header-errorX
    button(type='button', ng-click='cancel()').close &times;
    h4.modal-title.text-danger
      i.fa.fa-warning
      .button-spacer
      span(translate) Device was disconnected
  .modal-body
    h4(translate, ng-bind='device.likelyLeaveReason | likelyLeaveReason')
    br
    .big-thumbnail
      .device-photo-small
        img(ng-src='/static/app/devices/icon/x120/{{ device.image || "E30HT.jpg" }}')
      .device-name(ng-bind='device.enhancedName')
      h3.device-status(ng-class='stateColor')
        span(ng-bind='device.enhancedStatePassive | translate')

  .modal-footer
    button.btn.btn-primary-outline(type='button', ng-click='ok()')
      i.fa.fa-refresh
      span(translate) Try to reconnect
    //- button.btn.btn-success-outline(ng-click='second()')
    //-   i.fa.fa-sitemap
    //-   span(translate) Go to Device List
```

8. 修改默认显示中文

- 不需要改其他地方，改下面文件中的一个配置就行
- 文件：`res/app/components/stf/language/language-service.js`

```javascript
    LanguageService.settingKey = 'selectedLanguage'
    LanguageService.supportedLanguages = supportedLanguages
    LanguageService.defaultLanguage = 'zh_CN'
    LanguageService.detectedLanguage =
      onlySupported(detectLanguage(), LanguageService.defaultLanguage)
```

9. 修改操作手机页面中右键鼠标菜单的显示

- 文件：`res/app/components/stf/device-context-menu/device-context-menu.pug` 只需要屏蔽掉对应的按钮即可，代码如下

```jade
.dropdown.context-menu(id='context-menu-{{ $index }}')
  ul.dropdown-menu(role='menu')
    li
      a.pointer(role='menuitem', ng-click='control.back(); $event.preventDefault()')
        i.fa.fa-mail-reply.fa-fw
        span(translate) Back
    li
      a.pointer(role='menuitem', ng-click='control.home(); $event.preventDefault()')
        i.fa.fa-home.fa-fw
        span(translate) Home
    li
      a.pointer(role='menuitem', ng-click='control.appSwitch(); $event.preventDefault()')
        i.fa.fa-square-o.fa-fw
        span(translate) Recents
    li.divider
    li
      a.pointer(role='menuitem', ng-click='rotateRight(); $event.preventDefault()')
        i.fa.fa-rotate-left.fa-fw
        span(translate) Rotate Left
    li
      a.pointer(role='menuitem', ng-click='rotateLeft(); $event.preventDefault()')
        i.fa.fa-rotate-right.fa-fw
        span(translate) Rotate Right
    li.divider
    li
      a.pointer(role='menuitem', ng-click='saveScreenShot(); $event.preventDefault()')
        i.fa.fa-camera.fa-fw
        span(translate) Save ScreenShot
    //- li.divider
    //- li
    //-   a.pointer(role='menuitem', ng-click='$root.standalone ? windowClose() : kickDevice(device); $event.preventDefault()')
    //-     i.fa.fa-sign-out.fa-fw
    //-     span(translate) Stop Using

.stf-device-context-menu(ng-transclude, context-menu, data-target='context-menu-{{ $index }}').fill-height
```

### 修改API中断开设备的逻辑

- 未修改之前，断开设备时会去验证操作的那个用户 `Authorization Bearer` 是否和当前的 `Authorization Bearer` 一致
- 这样就会导致其他用户不能断开设备，会提示 `You cannot release this device. Not owned by you`
- 修改得也比较粗糙，屏蔽了API中的这个逻辑
- 文件：`lib/units/api/controllers/user.js` 中如下代码

```javascript
  dbapi.loadDevice(req.user.groups.subscribed, serial)
    .then(function(cursor) {
      cursor.next(function(err, device) {
        if (err) {
          return res.status(404).json({
            success: false
          , description: 'Device not found'
          })
        }

        // datautil.normalize(device, req.user)
        // if (!deviceutil.isOwnedByUser(device, req.user)) {
        //   return res.status(403).json({
        //     success: false
        //   , description: 'You cannot release this device. Not owned by you'
        //   })
        // }

        // Timer will be called if no JoinGroupMessage is received till 5 seconds
        var responseTimer = setTimeout(function() {
          req.options.channelRouter.removeListener(wireutil.global, messageListener)
          return res.status(504).json({
              success: false
            , description: 'Device is not responding'
          })
        }, 5000)
```

- ### 修改/屏蔽热键

- 文件：`res/app/control-panes/control-panes-hotkeys-controller.js`
- 修改以下代码即可

```javascript
ScopedHotkeysService($scope, [
      // ['shift+up', gettext('Previous Device'), actions.previousDevice],
      // ['shift+down', gettext('Next Device'), actions.nextDevice],
      ['command+shift+d', gettext('Go to Device List'), actions.deviceList],

      ['shift+space', gettext('Selects Next IME'), actions.switchCharset],
      ['command+left', gettext('Rotate Left'), actions.rotateLeft],
      ['command+right', gettext('Rotate Right'), actions.rotateRight],

      // ['command+1', gettext('Scale 100%'), actions.scale],
      // ['command+2', gettext('Scale 75%'), actions.scale],
      // ['command+3', gettext('Scale 50%'), actions.scale],

      // ['shift+l', gettext('Focus URL bar'), actions.focusUrlBar],
      // ['shift+s', gettext('Take Screenshot'), actions.takeScreenShot],

      ['command+shift+m', gettext('Press Menu button'), actions.pressMenu],
      ['command+shift+h', gettext('Press Home button'), actions.pressHome],
      ['command+shift+b', gettext('Press Back button'), actions.pressBack],

      // ['shift+i', gettext('Show/Hide device'), actions.toggleDevice],
      ['shift+w', gettext('Toggle Web/Native'), actions.togglePlatform, false]
    ])
```

### 修复每次断开连接后会重复装STF服务的BUG

- 因为GitHub上作者会不定时更新STF的APK包，更新包后会升级版本号，可能是由于作者疏忽忘了更新代码里面的版本号
- 导致每次断开手机再重新连接的时候，会重复安装STF服务，将以下代码中`requiredVersion`改成和当前项目中STFService.apk的一致
- `STFService.apk`的`Version`可在[查看STFService.apk的Version](https://github.com/openstf/stf/tree/master/vendor/STFService)
- 文件：`lib/units/device/resources/service.js`

```javascript
    var resource = {
      requiredVersion: '2.4.3'
    , pkg: 'jp.co.cyberagent.stf'
    , main: 'jp.co.cyberagent.stf.Agent'
    , apk: pathutil.vendor('STFService/STFService.apk')
    , wire: builder.build().jp.co.cyberagent.stf.proto
    , builder: builder
    , startIntent: {
        action: 'jp.co.cyberagent.stf.ACTION_START'
      , component: 'jp.co.cyberagent.stf/.Service'
      }
    }
```

## 修改每次断开连接后，安装的包会被清除掉

- 这个功能本意上是挺好的，意在每次用户断开连接后，自动清除安装的包，这样会保持手机始终都是最初的状态，不需要手动定期清除
- 但是目前这个系统只是内部使用，如果不小心断开连接，这个功能只会导致出现一些不必要的麻烦，故需要屏蔽掉
- 文件：`lib/units/device/plugins/cleanup.js` 中可以修改断开设备后的一些清理逻辑
- 文件：`lib/units/device/index.js` 中屏蔽掉对`cleanup`的引用即可

```javascript
        .dependency(require('./plugins/heartbeat'))
        .dependency(require('./plugins/solo'))
        .dependency(require('./plugins/screen/stream'))
        .dependency(require('./plugins/screen/capture'))
        .dependency(require('./plugins/vnc'))
        .dependency(require('./plugins/service'))
        .dependency(require('./plugins/browser'))
        .dependency(require('./plugins/store'))
        .dependency(require('./plugins/clipboard'))
        .dependency(require('./plugins/logcat'))
        .dependency(require('./plugins/mute'))
        .dependency(require('./plugins/shell'))
        .dependency(require('./plugins/touch'))
        .dependency(require('./plugins/install'))
        .dependency(require('./plugins/forward'))
        .dependency(require('./plugins/group'))
        // .dependency(require('./plugins/cleanup'))
        .dependency(require('./plugins/reboot'))
        .dependency(require('./plugins/connect'))
        .dependency(require('./plugins/account'))
        .dependency(require('./plugins/ringer'))
        .dependency(require('./plugins/wifi'))
        .dependency(require('./plugins/sd'))
        .dependency(require('./plugins/filesystem'))
```

## 修改STF-IOS版本的安装包导致服务奔溃的问题

- 文件：`lib/units/storage/temp.js` 中获取文件后缀名的逻辑改成下面这样

```javascript
    function catchtype(source) {
    var typestr = source.toLowerCase().substring(source.lastIndexOf('.') + 1)
    return typestr
  }

  app.post('/s/upload/:plugin', function(req, res) {
    var form = new formidable.IncomingForm({
      maxFileSize: options.maxFileSize
    })
    if (options.saveDir) {
      form.uploadDir = options.saveDir
    }
    form.on('fileBegin', function(name, file) {
      var md5 = crypto.createHash('md5')
      var myfilename = catchtype(file.name)
      log.info('输出文件后缀名', myfilename)
      file.name = md5.update(file.name).digest('hex') + '.' + myfilename
      log.info('输出文件名', file.name)
    })
```

## 修改默认15分钟不操作自动断开连接

- 文件：`lib/cli/local/index.js` 中128行位置，修改默认时间即可

```javascript
    .option('group-timeout', {
      alias: 't'
    , describe: 'Timeout in seconds for automatic release of inactive devices.'
    , type: 'number'
    , default: 900
    })
```



