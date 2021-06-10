> 相对于Linux上，Mac的搭建要简单不少，很多环境也只需一行命令就可以装上

## 一、基本环境安装

- 去brew官网，复制命令安装

## 二、配置Java环境

- 如果安装了brew后就可以直接用brew命令来安装一些软件了
  - `brew install java`

- 检查环境

  - `java -version`

  - `javac -version`

## 三、配置ADB（下面两种方式任选其一）

- 去安卓官网下载SDK

  - 下载好了后再配置环境变量

    - `vim .bash_profile`

      ```
      export PATH=${PATH}:/Users/lin/Library/Android/sdk/platform-tools; 
      export PATH=${PATH}:/Users/lin/Library/Android/sdk/tools;
      ```

    - `source .bash_profile`

- 直接安装Android Studio

  - 找到安装路径中的SDK路径

    - `vim .bash_profile`

      ```
      export PATH=${PATH}:/Users/lin/Library/Android/sdk/platform-tools; 
      export PATH=${PATH}:/Users/lin/Library/Android/sdk/tools;
      ```

      

      - `source .bash_profile`

- 检查ADB
  - `adb devices`

## 四、安装node

- `brew install node`
  - 此方法会安装最新的node，但STF对于最新的node的兼容并不是太好所以建议安装8.19.0版本
    - 如果已经安装好最新的node想降级，就用n来降级

- 切换`node`版本

  - `sudo npm install -g n`

    - 安装最新稳定版本
      - `sudo n stable`

    - 安装最新版本
      - `sudo n latest`

    - 安装指定版本
      - `sudu n 10.19.0`

    - 删除某个版本
      - `n rm 10.13.0 `

    - 使用n切换版本
      - `sudo n`

    - 以指定的版本来执行脚本
      - `sudo n use 10.19.0 index.js`

    - n帮助
      - sudo n help

- 检查`node`版本

  - `node -v`

  - `npm -v`

## 五、安装`rethinkdb`

- 用`brew`安装
  - `brew install rethinkdb`

- 检查安装
  - `rethinkdb -v`

## 六、安装支持IOS设备连接的依赖工具

- `brew install  usbmuxd`

- `brew link usbmuxd`

- `brew install --HEAD libimobiledevice`
  - 安装这两个工具的时候一定要用 --HEAD安装，否则不是最新的就获取不到设备信息，WDA会无限重启

- `brew install --HEAD ideviceinstaller`
  - 安装这两个工具的时候一定要用 --HEAD安装，否则不是最新的就获取不到设备信息，WDA会无限重启

- `brew install carthage`

- `brew install socat`

## 七、安装STF依赖

- `brew install graphicsmagick protobuf yasm pkg-config`

- 检查所有依赖是否已正常安装（后面也可以cd到STF的bin目录下./stf doctor来检测）

  - `graphicsmagick`
    - `gm`

  - `protobuf`
    - `protoc --version`

  - `yasm`
    - `yasm --version`

  - `plg-config`
    - `pkg-config --version`

- 安装zmq

  - 此工具不可用brew下载下来用，具体原因不太清楚，但是亲测是不行的，再执行./stf doctor时会包zmq的错

  - 先去git上下载一个最新的压缩包
    - https://github.com/zeromq/libzmq/releases
      - 解压，并cd到那个目录后`./configure`
        - `make && make install`

## 八、配置WebDriverAgent

- 拉取WDA代码
  - `git clone https://github.com/mrx1203/stf.git`

- 编译WDA
  - cd到WDA根目录
    - `./Scripts/bootstrap.sh`

- 用XCode打开WDA目录中的`WebDriverAgent.xcodeproj`

  - `WebDriverAgentLib`

    - `General`
      - 在Signin中的Team中选择自己的账号

    - `Build Settings`
      - 将`Build Bundle`改成自己的
        - 不知道自己的`Build Bundle`可以去重新创建一个项目，去同样的地方找到这个`Build Bundle`就可以了

  - `WebDriverAgentRunner`

    - `General`
      - 在`Signin`中的`Team`中选择自己的账号

    - `Build Settings`
      - 将`Build Bundle`改成自己的
        - 不知道自己的`Build Bundle`可以去重新创建一个项目，去同样的地方找到这个`Build Bundle`就可以了

- `Destinstion`
  - 选择自己的手机

- 在XCode里面选择
  - `product`
    - `schema`
      - `WebDriverAgentRunner`
        - `test`

## 九、STF重构

- 如果是源码安装的，有代码修改后，直接重启`stf`就行，会自动重构

## 十、启动STF

- 作为主服务器
  - `./stf local --public-ip 192.168.13.180 --wda-path /Users/lin/WebDriverAgent/ --wda-port 8100 --allow-remote`

- 作为从服务器

  - ```
    ./stf ios-provider --name "lin" --connect-sub tcp://192.168.9.121:7114 \ --connect-push tcp://192.168.9.121:7116 --storage-url http://192.168.9.121:7100 \ --public-ip 192.168.13.180 —heartbeat-interval 20000 \ --wda-path /Users/lin/WebDriverAgent --wda-port 8100
    ```

    