## 修改免登陆

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

## 修复某些电脑上不能正常显示字体的问题

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

  ## 修改界面

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

##修改API中断开设备的逻辑

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

## 修改/屏蔽热键

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

## 修复每次断开连接后会重复装STF服务的BUG

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

## 添加画质调整功能

- 文件：lib/units/device/plugins/screen/stream.js 中改为如下所示

```javascript
var util = require('util')

var Promise = require('bluebird')
var syrup = require('stf-syrup')
var WebSocket = require('ws')
var uuid = require('uuid')
var EventEmitter = require('eventemitter3')
var split = require('split')
var adbkit = require('adbkit')

var logger = require('../../../../util/logger')
var lifecycle = require('../../../../util/lifecycle')
var bannerutil = require('./util/banner')
var FrameParser = require('./util/frameparser')
var FrameConfig = require('./util/frameconfig')
var BroadcastSet = require('./util/broadcastset')
var StateQueue = require('../../../../util/statequeue')
var RiskyStream = require('../../../../util/riskystream')
var FailCounter = require('../../../../util/failcounter')

module.exports = syrup.serial()
  .dependency(require('../../support/adb'))
  .dependency(require('../../resources/minicap'))
  .dependency(require('../util/display'))
  .dependency(require('./options'))
  .define(function(options, adb, minicap, display, screenOptions) {
    var log = logger.createLogger('device:plugins:screen:stream')

    function FrameProducer(config) {
      EventEmitter.call(this)
      this.actionQueue = []
      this.runningState = FrameProducer.STATE_STOPPED
      this.desiredState = new StateQueue()
      this.output = null
      this.socket = null
      this.pid = -1
      this.banner = null
      this.parser = null
      this.frameConfig = config
      this.readable = false
      this.needsReadable = false
      this.failCounter = new FailCounter(3, 10000)
      this.failCounter.on('exceedLimit', this._failLimitExceeded.bind(this))
      this.failed = false
      this.readableListener = this._readableListener.bind(this)
    }

    util.inherits(FrameProducer, EventEmitter)

    FrameProducer.STATE_STOPPED = 1
    FrameProducer.STATE_STARTING = 2
    FrameProducer.STATE_STARTED = 3
    FrameProducer.STATE_STOPPING = 4

    FrameProducer.prototype._ensureState = function() {
      if (this.desiredState.empty()) {
        return
      }

      if (this.failed) {
        log.warn('Will not apply desired state due to too many failures')
        return
      }

      switch (this.runningState) {
      case FrameProducer.STATE_STARTING:
      case FrameProducer.STATE_STOPPING:
        // Just wait.
        break
      case FrameProducer.STATE_STOPPED:
        if (this.desiredState.next() === FrameProducer.STATE_STARTED) {
          this.runningState = FrameProducer.STATE_STARTING
          this._startService().bind(this)
            .then(function(out) {
              this.output = new RiskyStream(out)
                .on('unexpectedEnd', this._outputEnded.bind(this))
              return this._readOutput(this.output.stream)
            })
            .then(function() {
              return this._waitForPid()
            })
            .then(function() {
              return this._connectService()
            })
            .then(function(socket) {
              this.parser = new FrameParser()
              this.socket = new RiskyStream(socket)
                .on('unexpectedEnd', this._socketEnded.bind(this))
              return this._readBanner(this.socket.stream)
            })
            .then(function(banner) {
              this.banner = banner
              return this._readFrames(this.socket.stream)
            })
            .then(function() {
              this.runningState = FrameProducer.STATE_STARTED
              this.emit('start')
            })
            .catch(Promise.CancellationError, function() {
              return this._stop()
            })
            .catch(function(err) {
              return this._stop().finally(function() {
                this.failCounter.inc()
                this.emit('error', err)
              })
            })
            .finally(function() {
              this._ensureState()
            })
        }
        else {
          setImmediate(this._ensureState.bind(this))
        }
        break
      case FrameProducer.STATE_STARTED:
        if (this.desiredState.next() === FrameProducer.STATE_STOPPED) {
          this.runningState = FrameProducer.STATE_STOPPING
          this._stop().finally(function() {
            this._ensureState()
          })
        }
        else {
          setImmediate(this._ensureState.bind(this))
        }
        break
      }
    }

    FrameProducer.prototype.start = function() {
      log.info('Requesting frame producer to start')
      this.desiredState.push(FrameProducer.STATE_STARTED)
      this._ensureState()
    }

    FrameProducer.prototype.stop = function() {
      log.info('Requesting frame producer to stop')
      this.desiredState.push(FrameProducer.STATE_STOPPED)
      this._ensureState()
    }

    FrameProducer.prototype.restart = function() {
      switch (this.runningState) {
      case FrameProducer.STATE_STARTED:
      case FrameProducer.STATE_STARTING:
        this.desiredState.push(FrameProducer.STATE_STOPPED)
        this.desiredState.push(FrameProducer.STATE_STARTED)
        this._ensureState()
        break
      }
    }

    FrameProducer.prototype.updateRotation = function(rotation) {
      if (this.frameConfig.rotation === rotation) {
        log.info('Keeping %d as current frame producer rotation', rotation)
        return
      }

      log.info('Setting frame producer rotation to %d', rotation)
      this.frameConfig.rotation = rotation
      this._configChanged()
    }

    FrameProducer.prototype.updateProjection = function(width, height) {
      if (this.frameConfig.virtualWidth === width &&
          this.frameConfig.virtualHeight === height) {
        log.info(
          'Keeping %dx%d as current frame producer projection', width, height)
        return
      }

      log.info('Setting frame producer projection to %dx%d', width, height)
      this.frameConfig.virtualWidth = width
      this.frameConfig.virtualHeight = height
      this._configChanged()
    }

    FrameProducer.prototype.nextFrame = function() {
      var frame = null
      var chunk

      if (this.parser) {
        while ((frame = this.parser.nextFrame()) === null) {
          chunk = this.socket.stream.read()
          if (chunk) {
            this.parser.push(chunk)
          }
          else {
            this.readable = false
            break
          }
        }
      }

      return frame
    }

    FrameProducer.prototype.needFrame = function() {
      this.needsReadable = true
      this._maybeEmitReadable()
    }

    FrameProducer.prototype._configChanged = function() {
      this.restart()
    }

    FrameProducer.prototype._socketEnded = function() {
      log.warn('Connection to minicap ended unexpectedly')
      this.failCounter.inc()
      this.restart()
    }

    FrameProducer.prototype._outputEnded = function() {
      log.warn('Shell keeping minicap running ended unexpectedly')
      this.failCounter.inc()
      this.restart()
    }

    FrameProducer.prototype._failLimitExceeded = function(limit, time) {
      this._stop()
      this.failed = true
      this.emit('error', new Error(util.format(
        'Failed more than %d times in %dms'
      , limit
      , time
      )))
    }

    FrameProducer.prototype._startService = function() {
      log.info('Launching screen service')
      log.info('screenJpegQuality is ：' + options.screenJpegQuality + '%')
      return minicap.run(util.format(
          '-S -Q %d -P %s'
        , options.screenJpegQuality
        , this.frameConfig.toString()
        ))
        .timeout(10000)
    }

    FrameProducer.prototype._readOutput = function(out) {
      out.pipe(split()).on('data', function(line) {
        var trimmed = line.toString().trim()

        if (trimmed === '') {
          return
        }

        if (/ERROR/.test(line)) {
          log.fatal('minicap error: "%s"', line)
          return lifecycle.fatal()
        }

        var match = /^PID: (\d+)$/.exec(line)
        if (match) {
          this.pid = Number(match[1])
          this.emit('pid', this.pid)
        }

        log.info('minicap says: "%s"', line)
      }.bind(this))
    }

    FrameProducer.prototype._waitForPid = function() {
      if (this.pid > 0) {
        return Promise.resolve(this.pid)
      }

      var pidListener
      return new Promise(function(resolve) {
          this.on('pid', pidListener = resolve)
        }.bind(this)).bind(this)
        .timeout(2000)
        .finally(function() {
          this.removeListener('pid', pidListener)
        })
    }

    FrameProducer.prototype._connectService = function() {
      function tryConnect(times, delay) {
        return adb.openLocal(options.serial, 'localabstract:minicap')
          .timeout(10000)
          .then(function(out) {
            return out
          })
          .catch(function(err) {
            if (/closed/.test(err.message) && times > 1) {
              return Promise.delay(delay)
                .then(function() {
                  return tryConnect(times - 1, delay * 2)
                })
            }
            return Promise.reject(err)
          })
      }
      log.info('Connecting to minicap service')
      return tryConnect(5, 100)
    }

    FrameProducer.prototype._stop = function() {
      return this._disconnectService(this.socket).bind(this)
        .timeout(2000)
        .then(function() {
          return this._stopService(this.output).timeout(10000)
        })
        .then(function() {
          this.runningState = FrameProducer.STATE_STOPPED
          this.emit('stop')
        })
        .catch(function(err) {
          // In practice we _should_ never get here due to _stopService()
          // being quite aggressive. But if we do, well... assume it
          // stopped anyway for now.
          this.runningState = FrameProducer.STATE_STOPPED
          this.emit('error', err)
          this.emit('stop')
        })
        .finally(function() {
          this.output = null
          this.socket = null
          this.pid = -1
          this.banner = null
          this.parser = null
        })
    }

    FrameProducer.prototype._disconnectService = function(socket) {
      log.info('Disconnecting from minicap service')

      if (!socket || socket.ended) {
        return Promise.resolve(true)
      }

      socket.stream.removeListener('readable', this.readableListener)

      var endListener
      return new Promise(function(resolve) {
          socket.on('end', endListener = function() {
            resolve(true)
          })

          socket.stream.resume()
          socket.end()
        })
        .finally(function() {
          socket.removeListener('end', endListener)
        })
    }

    FrameProducer.prototype._stopService = function(output) {
      log.info('Stopping minicap service')

      if (!output || output.ended) {
        return Promise.resolve(true)
      }

      var pid = this.pid

      function kill(signal) {
        if (pid <= 0) {
          return Promise.reject(new Error('Minicap service pid is unknown'))
        }

        var signum = {
          SIGTERM: -15
        , SIGKILL: -9
        }[signal]

        log.info('Sending %s to minicap', signal)
        return Promise.all([
            output.waitForEnd()
          , adb.shell(options.serial, ['kill', signum, pid])
              .then(adbkit.util.readAll)
              .return(true)
          ])
          .timeout(2000)
      }

      function kindKill() {
        return kill('SIGTERM')
      }

      function forceKill() {
        return kill('SIGKILL')
      }

      function forceEnd() {
        log.info('Ending minicap I/O as a last resort')
        output.end()
        return Promise.resolve(true)
      }

      return kindKill()
        .catch(Promise.TimeoutError, forceKill)
        .catch(forceEnd)
    }

    FrameProducer.prototype._readBanner = function(socket) {
      log.info('Reading minicap banner')
      return bannerutil.read(socket).timeout(2000)
    }

    FrameProducer.prototype._readFrames = function(socket) {
      this.needsReadable = true
      socket.on('readable', this.readableListener)

      // We may already have data pending. Let the user know they should
      // at least attempt to read frames now.
      this.readableListener()
    }

    FrameProducer.prototype._maybeEmitReadable = function() {
      if (this.readable && this.needsReadable) {
        this.needsReadable = false
        this.emit('readable')
      }
    }

    FrameProducer.prototype._readableListener = function() {
      this.readable = true
      this._maybeEmitReadable()
    }

    function createServer() {
      log.info('Starting WebSocket server on port %d', screenOptions.publicPort)

      var wss = new WebSocket.Server({
        port: screenOptions.publicPort
      , perMessageDeflate: false
      })

      var listeningListener, errorListener
      return new Promise(function(resolve, reject) {
          listeningListener = function() {
            return resolve(wss)
          }

          errorListener = function(err) {
            return reject(err)
          }

          wss.on('listening', listeningListener)
          wss.on('error', errorListener)
        })
        .finally(function() {
          wss.removeListener('listening', listeningListener)
          wss.removeListener('error', errorListener)
        })
    }

    return createServer()
      .then(function(wss) {
        var frameProducer = new FrameProducer(
          new FrameConfig(display.properties, display.properties))
        var broadcastSet = frameProducer.broadcastSet = new BroadcastSet()

        broadcastSet.on('nonempty', function() {
          frameProducer.start()
        })

        broadcastSet.on('empty', function() {
          frameProducer.stop()
        })

        broadcastSet.on('insert', function(id) {
          // If two clients join a session in the middle, one of them
          // may not release the initial size because the projection
          // doesn't necessarily change, and the producer doesn't Getting
          // restarted. Therefore we have to call onStart() manually
          // if the producer is already up and running.
          switch (frameProducer.runningState) {
          case FrameProducer.STATE_STARTED:
            broadcastSet.get(id).onStart(frameProducer)
            break
          }
        })

        display.on('rotationChange', function(newRotation) {
          frameProducer.updateRotation(newRotation)
        })

        frameProducer.on('start', function() {
          broadcastSet.keys().map(function(id) {
            return broadcastSet.get(id).onStart(frameProducer)
          })
        })

        frameProducer.on('readable', function next() {
          var frame = frameProducer.nextFrame()
          if (frame) {
            Promise.settle([broadcastSet.keys().map(function(id) {
              return broadcastSet.get(id).onFrame(frame)
            })]).then(next)
          }
          else {
            frameProducer.needFrame()
          }
        })

        frameProducer.on('error', function(err) {
          log.fatal('Frame producer had an error', err.stack)
          lifecycle.fatal()
        })

        wss.on('connection', function(ws) {
          var id = uuid.v4()
          var pingTimer

          var lastsenttime = 0
          //帧数  默认值
          var framerate = 15
          //压缩比  默认值
          options.screenJpegQuality = 20

          function send(message, options) {
            return new Promise(function(resolve, reject) {
              switch (ws.readyState) {
              case WebSocket.OPENING:
                // This should never happen.
                log.warn('Unable to send to OPENING client "%s"', id)
                break
              case WebSocket.OPEN:
                // This is what SHOULD happen.
                ws.send(message, options, function(err) {
                  return err ? reject(err) : resolve()
                })
                break
              case WebSocket.CLOSING:
                // Ok, a 'close' event should remove the client from the set
                // soon.
                break
              case WebSocket.CLOSED:
                // This should never happen.
                log.warn('Unable to send to CLOSED client "%s"', id)
                clearInterval(pingTimer)
                broadcastSet.remove(id)
                break
              }
            })
          }

          function wsStartNotifier() {
            return send(util.format(
              'start %s'
            , JSON.stringify(frameProducer.banner)
            ))
          }

          function wsPingNotifier() {
            return send('ping')
          }
          //设置帧率
          // var lastsenttime = 0;
          function wsFrameNotifier(frame) {
            // var  framerate  = 60;
            // log.info("lastsenttime:",lastsenttime)            
            // log.info("帧数为：",framerate)
            if (lastsenttime == 0 || Date.now()-lastsenttime > 1000/framerate) {  
              // log.info("发送frame数据：",Date.now()-latesenttime)
              
              lastsenttime = Date.now()  
              return send(frame, {  
                binary: true  
              })  
            }  
            
          }

          // Sending a ping message every now and then makes sure that
          // reverse proxies like nginx don't time out the connection [1].
          //
          // [1] http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_read_timeout
          pingTimer = setInterval(wsPingNotifier, options.screenPingInterval)

          ws.on('message', function(data) {
            var match = /^(on|off|(size) ([0-9]+)x([0-9]+))$/.exec(data)
            log.info("match的值为：",match)
            if (match) {
              switch (match[2] || match[1]) {
              case 'on':
                broadcastSet.insert(id, {
                  onStart: wsStartNotifier
                , onFrame: wsFrameNotifier
                })
                break
              case 'off':
                broadcastSet.remove(id)
                // Keep pinging even when the screen is off.
                break
              case 'size':
                frameProducer.updateProjection(
                  Number(match[3]), Number(match[4]))
                break
              }
            }else{
              //根据传过来的画质设置改变压缩比和
              log.info('user set framerate：' + data)
              framerate = data
              if(framerate > 30) {
                options.screenJpegQuality = 80
              }
              else if(framerate > 15) {
                options.screenJpegQuality = 50
              }
              else{
                options.screenJpegQuality = 20
              }
              frameProducer.restart()
            }
          })

          ws.on('close', function() {
            clearInterval(pingTimer)
            broadcastSet.remove(id)
          })
        })

        lifecycle.observe(function() {
          wss.close()
        })

        lifecycle.observe(function() {
          frameProducer.stop()
        })

        return frameProducer
      })
  })

```

- 文件res/app/control-panes/device-control/device-control-controller.js 中147行位置修改默认帧率

```javascript
  //$scope.quality = '50'
 	$scope.quality = '15'
  $scope.rate = $scope.quality
  $scope.test = function() {
    // $log.log('调整画质为：' + $scope.quality)
    $scope.rate = $scope.quality
  }
```

- 文件res/app/control-panes/device-control/device-control.css 中添加一个样式

```css
.screen-quality {
  float: left !important;
  margin-top: 10px;
  text-align: center;
  margin-right: 5px;
}
```

- 文件res/app/control-panes/device-control/device-control.pug 中修改成如下，屏蔽了快速选择最近使用的手机下拉框，屏蔽了断开手机连接按钮和不显示手机屏幕按钮，如需要自行取消注释

```jade
.interact-control.fill-height.as-table.stf-device-control(ng-controller='DeviceControlCtrl')
  .as-cell.fill-height
    .as-table.fill-height
      .stf-vnc-navbar.as-row(ng-show='!$root.basicMode && !$root.standalone')
        .stf-vnc-control-header.as-cell
          .stf-vnc-right-buttons.pull-right
            .btn-group
              label.btn-sm.btn-primary-outline(type='button', ng-click='tryToRotate("portrait")',
              ng-model='currentRotation', uib-btn-radio='"portrait"',
              uib-tooltip='{{ "Portrait" | translate }} ({{ "Current rotation:" | translate }} {{ device.display.rotation }}°)', tooltip-placement='bottom').pointer
                i.fa.fa-mobile
              label.btn-sm.btn-primary-outline(type='button', ng-click='tryToRotate("landscape")',
                ng-model='currentRotation', uib-btn-radio='"landscape"',
              uib-tooltip='{{ "Landscape" | translate }} ({{ "Current rotation:" | translate }} {{ device.display.rotation }}°)', tooltip-placement='bottom').pointer
                i.fa.fa-mobile.fa-rotate-90
            //- 屏蔽不显示屏幕按钮，就是那个👁
            //- .button-spacer
            //- button(type='button', ng-model='showScreen', uib-btn-checkbox).btn.btn-xs.btn-info
            //-   i(ng-show='showScreen', uib-tooltip='{{"Hide Screen"|translate}}', tooltip-placement='bottom').fa.fa-eye
            //-   i(ng-show='!showScreen', uib-tooltip='{{"Show Screen"|translate}}', tooltip-placement='bottom').fa.fa-eye-slash
            //- 屏蔽断开连接按钮，（为了结合自己的平台而屏蔽的按钮）
            //- button(type='button', ng-click='kickDevice(device); $event.stopPropagation()', uib-tooltip='{{"Stop Using"|translate}}', tooltip-placement='bottom').btn.btn-sm.btn-danger-outline
            //-   i.fa.fa-times
            
          .screen-quality
            label 画质：
            select(ng-model='quality', ng-change="test()")
              option(value='60') 高
              option(value='30') 中
              option(value='15') 低
					//-  屏蔽快速选择最近使用的手机下拉框和手机型号手机图标显示
          //- .device-name-container.pull-left(uib-dropdown)
          //-   a.stf-vnc-device-name.pointer.unselectable(uib-dropdown-toggle)
          //-     p
          //-       .device-small-image
          //-         img(ng-src='/static/app/devices/icon/x24/{{ device.image || "E30HT.jpg" }}')
          //-       span.device-name-text {{ device.enhancedName }}
          //-       span.caret(ng-show='groupDevices.length > 0')

          //-   ul.dropdown-menu(role='menu', data-toggle='dropdown', ng-show='groupDevices.length > 0').pointer.unselectable
          //-     li(ng-repeat='groupDevice in groupDevices')
          //-       a.device-name-menu-element(ng-click='controlDevice(groupDevice); $event.stopPropagation()')
          //-         .pull-left
          //-           .device-small-image
          //-             img(ng-src='/static/app/devices/icon/x24/{{ groupDevice.image || "E30HT.jpg" }}')
          //-           span(ng-class='{"current-device": groupDevice.serial === device.serial }') {{ groupDevice.enhancedName }}

          //-         .pull-right(ng-click='kickDevice(groupDevice); $event.stopPropagation()').kick-device
          //-           i.fa.fa-times
          //-         .clearfix

      .as-row.fill-height
        div(ng-controller='DeviceScreenCtrl', ng-if='device').as-cell.fill-height
          div(ng-file-drop='installFile($files)', ng-file-drag-over-class='dragover').fill-height
            device-context-menu(device='device', control='control')
              device-screen(device='device', control='control',quality='rate')

      .stf-vnc-bottom.as-row(ng-hide='$root.standalone')
        .controls.as-cell
          .btn-group.btn-group-justified
            a(device-control-key='menu', title='{{"Menu"|translate}}').btn.btn-primary.btn-lg.no-transition
              i.fa.fa-bars
            a(device-control-key='home', title='{{"Home"|translate}}').btn.btn-primary.btn-lg.no-transition
              i.fa.fa-home
            a(device-control-key='app_switch', title='{{"App switch"|translate}}').btn.btn-primary.btn-lg.no-transition
              i.fa.fa-square-o
            a(device-control-key='back', title='{{"Back"|translate}}').btn.btn-primary.btn-lg.no-transition
              i.fa.fa-mail-reply

```

- 文件res/app/components/stf/screen/screen-directive.js 中修改成如下，添加quality ，rate等变量，这样就能从前端获取到传过来的画质切换信息了

  ```javascript
  var _ = require('lodash')
  var rotator = require('./rotator')
  var ImagePool = require('./imagepool')
  
  module.exports = function DeviceScreenDirective(
    $document
  , ScalingService
  , VendorUtil
  , PageVisibilityService
  , $timeout
  , $window
  ) {
    return {
      restrict: 'E'
    , template: require('./screen.pug')
    , scope: {
        control: '&'
      , device: '&'
      , quality: '='
      }
    , link: function(scope, element) {
        var URL = window.URL || window.webkitURL
        var BLANK_IMG =
          'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
        var cssTransform = VendorUtil.style(['transform', 'webkitTransform'])
  
        var device = scope.device()
        var control = scope.control()
        var rate = scope.quality
  
        var input = element.find('input')
  
        var screen = scope.screen = {
          rotation: 0
        , bounds: {
            x: 0
          , y: 0
          , w: 0
          , h: 0
          }
        }
  
        var scaler = ScalingService.coordinator(
          device.display.width
        , device.display.height
        )
  
        /**
         * SCREEN HANDLING
         *
         * This section should deal with updating the screen ONLY.
         */
        ;(function() {
          function stop() {
            try {
              ws.onerror = ws.onclose = ws.onmessage = ws.onopen = null
              ws.close()
              ws = null
            }
            catch (err) { /* noop */ }
          }
  
          var ws = new WebSocket(device.display.url)
          ws.binaryType = 'blob'
  
          ws.onerror = function errorListener() {
            // @todo Handle
          }
  
          ws.onclose = function closeListener() {
            // @todo Maybe handle
          }
  
          ws.onopen = function openListener() {
            checkEnabled()
          }
  
          var canvas = element.find('canvas')[0]
          var g = canvas.getContext('2d')
          var positioner = element.find('div')[0]
  
          function vendorBackingStorePixelRatio(g) {
            return g.webkitBackingStorePixelRatio ||
              g.mozBackingStorePixelRatio ||
              g.msBackingStorePixelRatio ||
              g.oBackingStorePixelRatio ||
              g.backingStorePixelRatio || 1
          }
  
          var devicePixelRatio = window.devicePixelRatio || 1
          var backingStoreRatio = vendorBackingStorePixelRatio(g)
          var frontBackRatio = devicePixelRatio / backingStoreRatio
  
          var options = {
            autoScaleForRetina: true
          , density: Math.max(1, Math.min(1.5, devicePixelRatio || 1))
          , minscale: 0.36
          }
  
          var adjustedBoundSize
          var cachedEnabled = false
  
          function updateBounds() {
            function adjustBoundedSize(w, h) {
              var sw = w * options.density
              var sh = h * options.density
              var f
  
              if (sw < (f = device.display.width * options.minscale)) {
                sw *= f / sw
                sh *= f / sh
              }
  
              if (sh < (f = device.display.height * options.minscale)) {
                sw *= f / sw
                sh *= f / sh
              }
  
              return {
                w: Math.ceil(sw)
              , h: Math.ceil(sh)
              }
            }
  
            // FIXME: element is an object HTMLUnknownElement in IE9
            var w = screen.bounds.w = element[0].offsetWidth
            var h = screen.bounds.h = element[0].offsetHeight
  
            // Developer error, let's try to reduce debug time
            if (!w || !h) {
              throw new Error(
                'Unable to read bounds; container must have dimensions'
              )
            }
  
            var newAdjustedBoundSize = (function() {
              switch (screen.rotation) {
              case 90:
              case 270:
                return adjustBoundedSize(h, w)
              case 0:
              case 180:
                /* falls through */
              default:
                return adjustBoundedSize(w, h)
              }
            })()
  
            if (!adjustedBoundSize ||
              newAdjustedBoundSize.w !== adjustedBoundSize.w ||
              newAdjustedBoundSize.h !== adjustedBoundSize.h) {
              adjustedBoundSize = newAdjustedBoundSize
              onScreenInterestAreaChanged()
            }
          }
  
          function shouldUpdateScreen() {
            return (
              // NO if the user has disabled the screen.
              scope.$parent.showScreen &&
              // NO if we're not even using the device anymore.
              device.using &&
              // NO if the page is not visible (e.g. background tab).
              !PageVisibilityService.hidden &&
              // NO if we don't have a connection yet.
              ws.readyState === WebSocket.OPEN
              // YES otherwise
            )
          }
  
          function checkEnabled() {
            var newEnabled = shouldUpdateScreen()
  
            if (newEnabled === cachedEnabled) {
              updateBounds()
            }
            else if (newEnabled) {
              updateBounds()
              onScreenInterestGained()
            }
            else {
              g.clearRect(0, 0, canvas.width, canvas.height)
              onScreenInterestLost()
            }
  
            cachedEnabled = newEnabled
          }
  
          function onScreenInterestGained() {
            if (ws.readyState === WebSocket.OPEN) {
              ws.send(rate)
              ws.send('size ' + adjustedBoundSize.w + 'x' + adjustedBoundSize.h)
              ws.send('on')
            }
          }
  
          scope.$watch('quality', function(newValue) {
            // $log.log('In screen-directive: rate change to ' + newValue)
            rate = newValue
            onScreenInterestGained()
          })
  
          function onScreenInterestAreaChanged() {
            if (ws.readyState === WebSocket.OPEN) {
              ws.send('size ' + adjustedBoundSize.w + 'x' + adjustedBoundSize.h)
            }
          }
  
          function onScreenInterestLost() {
            if (ws.readyState === WebSocket.OPEN) {
              ws.send('off')
            }
          }
  
          ws.onmessage = (function() {
            var cachedScreen = {
              rotation: 0
            , bounds: {
                x: 0
              , y: 0
              , w: 0
              , h: 0
              }
            }
  
            var cachedImageWidth = 0
            var cachedImageHeight = 0
            var cssRotation = 0
            var alwaysUpright = false
            var imagePool = new ImagePool(10)
  
            function applyQuirks(banner) {
              element[0].classList.toggle(
                'quirk-always-upright', alwaysUpright = banner.quirks.alwaysUpright)
            }
  
            function hasImageAreaChanged(img) {
              return cachedScreen.bounds.w !== screen.bounds.w ||
                cachedScreen.bounds.h !== screen.bounds.h ||
                cachedImageWidth !== img.width ||
                cachedImageHeight !== img.height ||
                cachedScreen.rotation !== screen.rotation
            }
  
            function isRotated() {
              return screen.rotation === 90 || screen.rotation === 270
            }
  
            function updateImageArea(img) {
              if (!hasImageAreaChanged(img)) {
                return
              }
  
              cachedImageWidth = img.width
              cachedImageHeight = img.height
  
              if (options.autoScaleForRetina) {
                canvas.width = cachedImageWidth * frontBackRatio
                canvas.height = cachedImageHeight * frontBackRatio
                g.scale(frontBackRatio, frontBackRatio)
              }
              else {
                canvas.width = cachedImageWidth
                canvas.height = cachedImageHeight
              }
  
              cssRotation += rotator(cachedScreen.rotation, screen.rotation)
  
              canvas.style[cssTransform] = 'rotate(' + cssRotation + 'deg)'
  
              cachedScreen.bounds.h = screen.bounds.h
              cachedScreen.bounds.w = screen.bounds.w
              cachedScreen.rotation = screen.rotation
  
              canvasAspect = canvas.width / canvas.height
  
              if (isRotated() && !alwaysUpright) {
                canvasAspect = img.height / img.width
                element[0].classList.add('rotated')
              }
              else {
                canvasAspect = img.width / img.height
                element[0].classList.remove('rotated')
              }
  
              if (alwaysUpright) {
                // If the screen image is always in upright position (but we
                // still want the rotation animation), we need to cancel out
                // the rotation by using another rotation.
                positioner.style[cssTransform] = 'rotate(' + -cssRotation + 'deg)'
              }
  
              maybeFlipLetterbox()
            }
  
            return function messageListener(message) {
              screen.rotation = device.display.rotation
  
              if (message.data instanceof Blob) {
                if (shouldUpdateScreen()) {
                  if (scope.displayError) {
                    scope.$apply(function() {
                      scope.displayError = false
                    })
                  }
  
                  var blob = new Blob([message.data], {
                    type: 'image/jpeg'
                  })
  
                  var img = imagePool.next()
  
                  img.onload = function() {
                    updateImageArea(this)
  
                    g.drawImage(img, 0, 0, img.width, img.height)
  
                    // Try to forcefully clean everything to get rid of memory
                    // leaks. Note that despite this effort, Chrome will still
                    // leak huge amounts of memory when the developer tools are
                    // open, probably to save the resources for inspection. When
                    // the developer tools are closed no memory is leaked.
                    img.onload = img.onerror = null
                    img.src = BLANK_IMG
                    img = null
                    blob = null
  
                    URL.revokeObjectURL(url)
                    url = null
                  }
  
                  img.onerror = function() {
                    // Happily ignore. I suppose this shouldn't happen, but
                    // sometimes it does, presumably when we're loading images
                    // too quickly.
  
                    // Do the same cleanup here as in onload.
                    img.onload = img.onerror = null
                    img.src = BLANK_IMG
                    img = null
                    blob = null
  
                    URL.revokeObjectURL(url)
                    url = null
                  }
  
                  var url = URL.createObjectURL(blob)
                  img.src = url
                }
              }
              else if (/^start /.test(message.data)) {
                applyQuirks(JSON.parse(message.data.substr('start '.length)))
              }
              else if (message.data === 'secure_on') {
                scope.$apply(function() {
                  scope.displayError = 'secure'
                })
              }
            }
          })()
  
          // NOTE: instead of fa-pane-resize, a fa-child-pane-resize could be better
          scope.$on('fa-pane-resize', _.debounce(updateBounds, 1000))
          scope.$watch('device.using', checkEnabled)
          scope.$on('visibilitychange', checkEnabled)
          scope.$watch('$parent.showScreen', checkEnabled)
  
          scope.retryLoadingScreen = function() {
            if (scope.displayError === 'secure') {
              control.home()
            }
          }
  
          scope.$on('guest-portrait', function() {
            control.rotate(0)
          })
  
          scope.$on('guest-landscape', function() {
            control.rotate(90)
          })
  
          var canvasAspect = 1
          var parentAspect = 1
  
          function resizeListener() {
            parentAspect = element[0].offsetWidth / element[0].offsetHeight
            maybeFlipLetterbox()
          }
  
          function maybeFlipLetterbox() {
            element[0].classList.toggle(
              'letterboxed', parentAspect < canvasAspect)
          }
  
          $window.addEventListener('resize', resizeListener, false)
          scope.$on('fa-pane-resize', resizeListener)
  
          resizeListener()
  
          scope.$on('$destroy', function() {
            stop()
            $window.removeEventListener('resize', resizeListener, false)
          })
        })()
  
        /**
         * KEYBOARD HANDLING
         *
         * This should be moved elsewhere, but due to shared dependencies and
         * elements it's currently here. So basically due to laziness.
         *
         * For now, try to keep the whole section as a separate unit as much
         * as possible.
         */
        ;(function() {
          function isChangeCharsetKey(e) {
            // Add any special key here for changing charset
            //console.log('e', e)
  
            // Chrome/Safari/Opera
            if (
              // Mac | Kinesis keyboard | Karabiner | Latin key, Kana key
            e.keyCode === 0 && e.keyIdentifier === 'U+0010' ||
  
              // Mac | MacBook Pro keyboard | Latin key, Kana key
            e.keyCode === 0 && e.keyIdentifier === 'U+0020' ||
  
              // Win | Lenovo X230 keyboard | Alt+Latin key
            e.keyCode === 246 && e.keyIdentifier === 'U+00F6' ||
  
              // Win | Lenovo X230 keyboard | Convert key
            e.keyCode === 28 && e.keyIdentifier === 'U+001C'
            ) {
              return true
            }
  
            // Firefox
            switch (e.key) {
              case 'Convert': // Windows | Convert key
              case 'Alphanumeric': // Mac | Latin key
              case 'RomanCharacters': // Windows/Mac | Latin key
              case 'KanjiMode': // Windows/Mac | Kana key
                return true
            }
  
            return false
          }
  
          function handleSpecialKeys(e) {
            if (isChangeCharsetKey(e)) {
              e.preventDefault()
              control.keyPress('switch_charset')
              return true
            }
  
            return false
          }
  
          function keydownListener(e) {
            // Prevent tab from switching focus to the next element, we only want
            // that to happen on the device side.
            if (e.keyCode === 9) {
              e.preventDefault()
            }
            control.keyDown(e.keyCode)
          }
  
          function keyupListener(e) {
            if (!handleSpecialKeys(e)) {
              control.keyUp(e.keyCode)
            }
          }
  
          function pasteListener(e) {
            // Prevent value change or the input event sees it. This way we get
            // the real value instead of any "\n" -> " " conversions we might see
            // in the input value.
            e.preventDefault()
            control.paste(e.clipboardData.getData('text/plain'))
          }
  
          function copyListener(e) {
            e.preventDefault()
            // This is asynchronous and by the time it returns we will no longer
            // have access to setData(). In other words it doesn't work. Currently
            // what happens is that on the first copy, it will attempt to fetch
            // the clipboard contents. Only on the second copy will it actually
            // copy that to the clipboard.
            control.getClipboardContent()
            if (control.clipboardContent) {
              e.clipboardData.setData('text/plain', control.clipboardContent)
            }
          }
  
          function inputListener() {
            // Why use the input event if we don't let it handle pasting? The
            // reason is that on latest Safari (Version 8.0 (10600.1.25)), if
            // you use the "Romaji" Kotoeri input method, we'll never get any
            // keypress events. It also causes us to lose the very first keypress
            // on the page. Currently I'm not sure if we can fix that one.
            control.type(this.value)
            this.value = ''
          }
  
          input.bind('keydown', keydownListener)
          input.bind('keyup', keyupListener)
          input.bind('input', inputListener)
          input.bind('paste', pasteListener)
          input.bind('copy', copyListener)
        })()
  
        /**
         * TOUCH HANDLING
         *
         * This should be moved elsewhere, but due to shared dependencies and
         * elements it's currently here. So basically due to laziness.
         *
         * For now, try to keep the whole section as a separate unit as much
         * as possible.
         */
        ;(function() {
          var slots = []
          var slotted = Object.create(null)
          var fingers = []
          var seq = -1
          var cycle = 100
          var fakePinch = false
          var lastPossiblyBuggyMouseUpEvent = 0
  
          function nextSeq() {
            return ++seq >= cycle ? (seq = 0) : seq
          }
  
          function createSlots() {
            // The reverse order is important because slots and fingers are in
            // opposite sort order. Anyway don't change anything here unless
            // you understand what it does and why.
            for (var i = 9; i >= 0; --i) {
              var finger = createFinger(i)
              element.append(finger)
              slots.push(i)
              fingers.unshift(finger)
            }
          }
  
          function activateFinger(index, x, y, pressure) {
            var scale = 0.5 + pressure
            fingers[index].classList.add('active')
            fingers[index].style[cssTransform] =
              'translate3d(' + x + 'px,' + y + 'px,0) ' +
              'scale(' + scale + ',' + scale + ')'
          }
  
          function deactivateFinger(index) {
            fingers[index].classList.remove('active')
          }
  
          function deactivateFingers() {
            for (var i = 0, l = fingers.length; i < l; ++i) {
              fingers[i].classList.remove('active')
            }
          }
  
          function createFinger(index) {
            var el = document.createElement('span')
            el.className = 'finger finger-' + index
            return el
          }
  
          function calculateBounds() {
            var el = element[0]
  
            screen.bounds.w = el.offsetWidth
            screen.bounds.h = el.offsetHeight
            screen.bounds.x = 0
            screen.bounds.y = 0
  
            while (el.offsetParent) {
              screen.bounds.x += el.offsetLeft
              screen.bounds.y += el.offsetTop
              el = el.offsetParent
            }
          }
  
          function mouseDownListener(event) {
            var e = event
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            // Skip secondary click
            if (e.which === 3) {
              return
            }
  
            e.preventDefault()
  
            fakePinch = e.altKey
  
            calculateBounds()
            startMousing()
  
            var x = e.pageX - screen.bounds.x
            var y = e.pageY - screen.bounds.y
            var pressure = 0.5
            var scaled = scaler.coords(
                  screen.bounds.w
                , screen.bounds.h
                , x
                , y
                , screen.rotation
                )
  
            control.touchDown(nextSeq(), 0, scaled.xP, scaled.yP, pressure)
  
            if (fakePinch) {
              control.touchDown(nextSeq(), 1, 1 - scaled.xP, 1 - scaled.yP,
                pressure)
            }
  
            control.touchCommit(nextSeq())
  
            activateFinger(0, x, y, pressure)
  
            if (fakePinch) {
              activateFinger(1, -e.pageX + screen.bounds.x + screen.bounds.w,
                -e.pageY + screen.bounds.y + screen.bounds.h, pressure)
            }
  
            element.bind('mousemove', mouseMoveListener)
            $document.bind('mouseup', mouseUpListener)
            $document.bind('mouseleave', mouseUpListener)
  
            if (lastPossiblyBuggyMouseUpEvent &&
                lastPossiblyBuggyMouseUpEvent.timeStamp > e.timeStamp) {
              // We got mouseup before mousedown. See mouseUpBugWorkaroundListener
              // for details.
              mouseUpListener(lastPossiblyBuggyMouseUpEvent)
            }
            else {
              lastPossiblyBuggyMouseUpEvent = null
            }
          }
  
          function mouseMoveListener(event) {
            var e = event
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            // Skip secondary click
            if (e.which === 3) {
              return
            }
            e.preventDefault()
  
            var addGhostFinger = !fakePinch && e.altKey
            var deleteGhostFinger = fakePinch && !e.altKey
  
            fakePinch = e.altKey
  
            var x = e.pageX - screen.bounds.x
            var y = e.pageY - screen.bounds.y
            var pressure = 0.5
            var scaled = scaler.coords(
                  screen.bounds.w
                , screen.bounds.h
                , x
                , y
                , screen.rotation
                )
  
            control.touchMove(nextSeq(), 0, scaled.xP, scaled.yP, pressure)
  
            if (addGhostFinger) {
              control.touchDown(nextSeq(), 1, 1 - scaled.xP, 1 - scaled.yP, pressure)
            }
            else if (deleteGhostFinger) {
              control.touchUp(nextSeq(), 1)
            }
            else if (fakePinch) {
              control.touchMove(nextSeq(), 1, 1 - scaled.xP, 1 - scaled.yP, pressure)
            }
  
            control.touchCommit(nextSeq())
  
            activateFinger(0, x, y, pressure)
  
            if (deleteGhostFinger) {
              deactivateFinger(1)
            }
            else if (fakePinch) {
              activateFinger(1, -e.pageX + screen.bounds.x + screen.bounds.w,
                -e.pageY + screen.bounds.y + screen.bounds.h, pressure)
            }
          }
  
          function mouseUpListener(event) {
            var e = event
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            // Skip secondary click
            if (e.which === 3) {
              return
            }
            e.preventDefault()
  
            control.touchUp(nextSeq(), 0)
  
            if (fakePinch) {
              control.touchUp(nextSeq(), 1)
            }
  
            control.touchCommit(nextSeq())
  
            deactivateFinger(0)
  
            if (fakePinch) {
              deactivateFinger(1)
            }
  
            stopMousing()
          }
  
          /**
           * Do NOT remove under any circumstances. Currently, in the latest
           * Safari (Version 8.0 (10600.1.25)), if an input field is focused
           * while we do a tap click on an MBP trackpad ("Tap to click" in
           * Settings), it sometimes causes the mouseup event to trigger before
           * the mousedown event (but event.timeStamp will be correct). It
           * doesn't happen in any other browser. The following minimal test
           * case triggers the same behavior (although less frequently). Keep
           * tapping and you'll eventually see see two mouseups in a row with
           * the same counter value followed by a mousedown with a new counter
           * value. Also, when the bug happens, the cursor in the input field
           * stops blinking. It may take up to 300 attempts to spot the bug on
           * a MacBook Pro (Retina, 15-inch, Mid 2014).
           *
           *     <!doctype html>
           *
           *     <div id="touchable"
           *       style="width: 100px; height: 100px; background: green"></div>
           *     <input id="focusable" type="text" />
           *
           *     <script>
           *     var touchable = document.getElementById('touchable')
           *       , focusable = document.getElementById('focusable')
           *       , counter = 0
           *
           *     function mousedownListener(e) {
           *       counter += 1
           *       console.log('mousedown', counter, e, e.timeStamp)
           *       e.preventDefault()
           *     }
           *
           *     function mouseupListener(e) {
           *       e.preventDefault()
           *       console.log('mouseup', counter, e, e.timeStamp)
           *       focusable.focus()
           *     }
           *
           *     touchable.addEventListener('mousedown', mousedownListener, false)
           *     touchable.addEventListener('mouseup', mouseupListener, false)
           *     </script>
           *
           * I believe that the bug is caused by some kind of a race condition
           * in Safari. Using a textarea or a focused contenteditable does not
           * get rid of the bug. The bug also happens if the text field is
           * focused manually by the user (not with .focus()).
           *
           * It also doesn't help if you .blur() before .focus().
           *
           * So basically we'll just have to store the event on mouseup and check
           * if we should do the browser's job in the mousedown handler.
           */
          function mouseUpBugWorkaroundListener(e) {
            lastPossiblyBuggyMouseUpEvent = e
          }
  
          function startMousing() {
            control.gestureStart(nextSeq())
            input[0].focus()
          }
  
          function stopMousing() {
            element.unbind('mousemove', mouseMoveListener)
            $document.unbind('mouseup', mouseUpListener)
            $document.unbind('mouseleave', mouseUpListener)
            deactivateFingers()
            control.gestureStop(nextSeq())
          }
  
          function touchStartListener(event) {
            var e = event
            e.preventDefault()
  
            //Make it jQuery compatible also
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            calculateBounds()
  
            if (e.touches.length === e.changedTouches.length) {
              startTouching()
            }
  
            var currentTouches = Object.create(null)
            var i, l
  
            for (i = 0, l = e.touches.length; i < l; ++i) {
              currentTouches[e.touches[i].identifier] = 1
            }
  
            function maybeLostTouchEnd(id) {
              return !(id in currentTouches)
            }
  
            // We might have lost a touchend event due to various edge cases
            // (literally) such as dragging from the bottom of the screen so that
            // the control center appears. If so, let's ask for a reset.
            if (Object.keys(slotted).some(maybeLostTouchEnd)) {
              Object.keys(slotted).forEach(function(id) {
                slots.push(slotted[id])
                delete slotted[id]
              })
              slots.sort().reverse()
              control.touchReset(nextSeq())
              deactivateFingers()
            }
  
            if (!slots.length) {
              // This should never happen but who knows...
              throw new Error('Ran out of multitouch slots')
            }
  
            for (i = 0, l = e.changedTouches.length; i < l; ++i) {
              var touch = e.changedTouches[i]
              var slot = slots.pop()
              var x = touch.pageX - screen.bounds.x
              var y = touch.pageY - screen.bounds.y
              var pressure = touch.force || 0.5
              var scaled = scaler.coords(
                    screen.bounds.w
                  , screen.bounds.h
                  , x
                  , y
                  , screen.rotation
                  )
  
              slotted[touch.identifier] = slot
              control.touchDown(nextSeq(), slot, scaled.xP, scaled.yP, pressure)
              activateFinger(slot, x, y, pressure)
            }
  
            element.bind('touchmove', touchMoveListener)
            $document.bind('touchend', touchEndListener)
            $document.bind('touchleave', touchEndListener)
  
            control.touchCommit(nextSeq())
          }
  
          function touchMoveListener(event) {
            var e = event
            e.preventDefault()
  
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            for (var i = 0, l = e.changedTouches.length; i < l; ++i) {
              var touch = e.changedTouches[i]
              var slot = slotted[touch.identifier]
              var x = touch.pageX - screen.bounds.x
              var y = touch.pageY - screen.bounds.y
              var pressure = touch.force || 0.5
              var scaled = scaler.coords(
                    screen.bounds.w
                  , screen.bounds.h
                  , x
                  , y
                  , screen.rotation
                  )
  
              control.touchMove(nextSeq(), slot, scaled.xP, scaled.yP, pressure)
              activateFinger(slot, x, y, pressure)
            }
  
            control.touchCommit(nextSeq())
          }
  
          function touchEndListener(event) {
            var e = event
            if (e.originalEvent) {
              e = e.originalEvent
            }
  
            var foundAny = false
  
            for (var i = 0, l = e.changedTouches.length; i < l; ++i) {
              var touch = e.changedTouches[i]
              var slot = slotted[touch.identifier]
              if (typeof slot === 'undefined') {
                // We've already disposed of the contact. We may have gotten a
                // touchend event for the same contact twice.
                continue
              }
              delete slotted[touch.identifier]
              slots.push(slot)
              control.touchUp(nextSeq(), slot)
              deactivateFinger(slot)
              foundAny = true
            }
  
            if (foundAny) {
              control.touchCommit(nextSeq())
              if (!e.touches.length) {
                stopTouching()
              }
            }
          }
  
          function startTouching() {
            control.gestureStart(nextSeq())
          }
  
          function stopTouching() {
            element.unbind('touchmove', touchMoveListener)
            $document.unbind('touchend', touchEndListener)
            $document.unbind('touchleave', touchEndListener)
            deactivateFingers()
            control.gestureStop(nextSeq())
          }
  
          element.on('touchstart', touchStartListener)
          element.on('mousedown', mouseDownListener)
          element.on('mouseup', mouseUpBugWorkaroundListener)
  
          createSlots()
        })()
      }
    }
  }
  
  ```

  