## 一、cnpm

- 国外某些源可能被墙，所以需要安装一个淘宝的源

  - `npm install -g cnpm --registry=https://registry.npm.taobao.org`

  ps: *在使用过程中发现用`cnpm会`安装失败，用`npm`反倒正常，如遇到异常情况，请使用`npm`安装*

## 二、adb

- 下载并安装`Android Studio`来安装` platform-tools`（和下面直接下载sdk-tools的方式任选其一）

  - https://developer.android.google.cn/studio

  - 安装完成后，找到SDK的目录

  - 添加环境变量
    - `vim /etc/profile`
    - 输入`i`
    - `export PATH=$PATH:/root/Android/Sdk/platform-tools`
    - 按esc退出编辑模式并输入`:wq!`

  - `source /etc/profile`

- 通过下载sdk-tools来安装 `platform-tools`

  - `wget  https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip`

  - `unzip sdk-tools-linux-3859397.zip `

  - 添加环境变量 `vim /etc/profile`
    - `export PATH=$PATH:/usr/local/android/tools/bin` 这里的目录就是刚才解压后的tools/bin目录
    - 按esc退出编辑模式并输入`:wq!`
    - `source /etc/profile`

- 直接使用附件（除了这个方法不需要VPN以上两种方法都需要VPN）

  - [platform-tools.zip](https://github.com/lin54241930/yun_mobile/blob/main/tools/platform-tools.zip)

    - 解压
    - 添加环境变量` vim /etc/profile`
      - `export PATH=$PATH:/usr/local/android/tools/bin `这里的目录就是刚才解压后的tools/bin目录

    - `source /etc/profile`

## 三、RethinkDB

- 添加安装源，详情见官网 https://rethinkdb.com/docs/install/centos/

- ```
  sudo cat << EOF > /etc/yum.repos.d/rethinkdb.repo
  [rethinkdb]
  name=RethinkDB
  enabled=1
  baseurl=https://download.rethinkdb.com/repository/centos/7/x86_64/
  gpgkey=https://download.rethinkdb.com/repository/raw/pubkey.gpg
  gpgcheck=1
  EOF
  ```

- `yum install rethinkdb`

- 检验安装
  - `rethinkdb --version`
    - 输出 rethinkdb 2.4.1 (GCC 4.8.5)

## 四、GraphicsMagick

- 去官网下载
  - 下载最新的 http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/
    - 下载到本地再上传至服务器

- 通过wget命令下载
  - `wget http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/1.3/GraphicsMagick-1.3.36.tar.gz`

- 解压并进入到目录中

  - `tar -xvf GraphicsMagick-1.3.36.tar.gz`

  - `cd GraphicsMagick-1.3.36`

- 进行编译安装

  - `./configure`

  - `make && make install`

- 检验安装
  - gm
    - 有输出版本代表安装成功

## 五、libsodium

- 去官网下载
  - 下载最新的 https://download.libsodium.org/libsodium/releases
    - 下载到本地再上传至服务器

- 通过wget命令下载
  - `wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18-stable.tar.gz`

- 解压并进入到目录中

  - `tar -xvf libsodium-1.0.18-stable.tar.gz `

  - `cd libsodium-stable`

- 进行编译安装

  - `./configure`

  - `make && make install`

- 验证安装
  - `whereis libsodium`
    - 输出 libsodium: /usr/local/lib/libsodium.so /usr/local/lib/libsodium.la /usr/local/lib/libsodium.a

## 六、ZeroMQ

- 安装这个之前得先安装libsodium

- 去GitHub上下载一个最新的包

  - https://github.com/zeromq/libzmq/releases

    - 由于后期可能会更新，所以下载最新的.tar.gz包即可

    - 例如这样的一个包 zeromq-4.3.4.tar.gz

    - 下载到本地再上传至服务器

- 也可通过wget命令下载
  - `wget https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz`

- 解压并进入到目录中

  - `tar -xvf zeromq-4.3.4.tar.gz`

  - `cd zeromq-4.3.4`

- 进行编译安装

  - `./configure`

  - `make && make install`

## 七、protobuf

- 去GitHub上下载一个最新的包

  - https://github.com/protocolbuffers/protobuf/releases

    - 由于后期可能会更新，所以下载最新的.tar.gz包即可

    - 例如这样的一个包 protobuf-cpp-3.15.5.tar.gz

    - 下载到本地再上传至服务器

- 也可通过wget命令下载
  - `wget https://github.com/protocolbuffers/protobuf/releases/download/v3.15.5/protobuf-cpp-3.15.5.tar.gz`

- 解压并进入到目录中

  - `tar -xvf protobuf-cpp-3.15.5.tar.gz`

  - `cd protobuf-3.15.5`

- 进行编译安装

  - `./configure --prefix=/usr/local/protobuf`
    - 注意这步与上面不一样，需要指定路径，方便配置环境变量

  - `make && make install`

- 配置环境变量

  - `vim /etc/profile`

  - `输入“i”`

  - `export PATH=$PATH:/usr/local/protobuf/bin/`

  - `export PKG_CONFIG_PATH=/usr/local/protobuf/lib/pkgconfig/`

  - `输入“wq!”`

  - `source /etc/profile`

- 验证安装
  - `protoc --version`
    - `输出 libprotoc 3.15.5`

## 八、yasm

- 去官网下载
  - 下载最新的 http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
    - 下载到本地再上传至服务器

- 通过wget命令下载
  - `wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz`

- 解压并进入到目录中

  - `tar -xvf yasm-1.3.0.tar.gz`

  - `cd yasm-1.3.0`

- 进行编译安装

  - `./configure`

  - `make && make install`

- 验证安装
  - `yasm --version`
    - 输出 yasm 1.3.0

## 九、pkg-config

- 去官网下载
  - 下载最新的 http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
    - 下载到本地再上传至服务器

- 通过wget命令下载
  - `wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz`

- 解压并进入到目录中

  - `tar -xvf pkg-config-0.29.2.tar.gz`

  - `cd pkg-config-0.29.2`

- 进行编译安装

  - `./configure --prefix=/usr/local/pkg-config --with-internal-glib`
    - 这里也需要指定路径

  - `make && make install`

- 验证安装
  - `pkg-config --version`
    - 输出 0.27.1

## 十、CMake

- 源码安装

  - https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4.tar.gz
    - 下载下来后传到服务器上

  - 通过 wget 命令下载
    - `wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4.tar.gz`

  - 解压并进入到目录中

    - `tar -xvf cmake-3.20.0-rc4.tar.gz`

    - `cd cmake-3.20.0-rc4`

  - 进行编译安装

    - `./configure`

    - `make && make install`

  - 验证安装
    - `cmake --version`
      - 输出 cmake version 3.20.0-rc4

- 使用编译好的(建议使用这个)

  - https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4-linux-x86_64.tar.gz
    - 下载下来后传到服务器上

  - 通过 wget 命令下载
    - `wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4-linux-x86_64.tar.gz`

  - 解压并进入到目录中

    - `tar -xvf cmake-3.20.0-rc4-linux-x86_64.tar.gz`

    - `cd cmake-3.20.0-rc4-linux-x86_64/bin`

  - 添加软连
    - `ln -s cmake /usr/local/bin/cmake`

  - 验证安装

    - `cmake --version`

      - 输出 cmake version 3.20.0-rc4

      - 如添加软连后还是不能正确输出版本号，请添加环境变量

        - `vim /etc/profile`

          - 输如“i”进入编辑模式

          - 在最后添加 `export PATH=$PATH:/usr/local/cmake-3.20.0-rc4-linux-x86_64/bin`

          - 按esc退出编辑模式

          - 输入“:wq!”保存并退出

          - `source /etc/profile`