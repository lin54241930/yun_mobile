> 安装一般用docker比较方便，因为没有那么多环境需要装，不过如果想进行二次开发的话，还是本地部署吧，本地部署也分两种，一种是源码安装，一种是直接`npm`安装，直接`npm`安装的话一般是全局安装，后续修改`stf`的源代码时，需要到安装目录去找，不是很方便，且直接`npm`安装那种方式是官方发布的文档版本，如果官方有修改`BUG`的话，还是通过`GitHub`拉下来的源代码安装较为方便快捷

## 一、源码安装

- （方法一）去GitHub上手动下载stf源码（这种方式可以获取到最新的stf但是需要修改stf源代码才能适配Tcloud）
  - https://github.com/DeviceFarmer/stf

  - 使用git clone下载到服务器
  - `git clone https://github.com/DeviceFarmer/stf.git`
  - `cd stf`
- （方法二）直接进入到`yun_mobile/stf`目录下（这里的stf是我针对Tcloud修改过的，npm install后就可直接使用，无需修改stf源代码，修改详情见https://github.com/lin54241930/yun_mobile/blob/main/doc/STF%E4%BF%AE%E6%94%B9%E9%A1%B9.md）

- 进行安装

  - 有vpn
    - `npm install`
      - 如出现与`python`相关的报错，则需要安装`python2`（这里只在centos8上的系统遇到过）

  - 没有`vpn`请使用`cnpm`

    - `cnpm install`

      - 如果使用了`cnpm`就无法使用`npm`安装

      - 使用`cnpm`安装后如再想使用npm安装则需要删掉项目目录下`node_modules`文件夹

    - 用下来发现使用`cnpm`问题会很多，不建议使用`cnpm`

  - 如果执行一次npm install/cnpm install不行的话，就多执行几次

  - 安装中如遇到报 “Failed at the @julusian/jpeg-turbo@0.5.6 install script”
    - 单独执行一次` npm install --save @julusian/jpeg-turbo`

- 检验安装

  - `cd bin`

  - `./stf doctor`

    - 如出现zmq的问题

      - `cd ../node_modules/zmq`

      - `npm install --unsafe-perm`

      - `cd ../../bin`

      - 再次检验安装

        - `./stf doctor`

          - 如出现 “Unexpected error checking ZeroMQ: Error: libzmq.so.5: cannot open shared object file: No such file or directory”

            - `vim /etc/ld.so.conf`

            - 输出“i”进入编辑模式

            - 新增一行` /usr/local/lib`

            - :wq!保存并退出

            - 再执行`ldconfig`

            - 再次验证安装
              - 输出

- 会出现的问题

  - 最开始使用cnpm安装，后续又用npm安装，出现卡死，这时需要删掉node_modules后再使用npm安装

  - adb

    - 运行`./stf doctor`时出现adb的报错` Unexpected error checking ADB: Error: spawn ELOOP`

    - 这个是环境问题，`adb`需要设置环境变量，不能使用软链

  - 使用`cnpm`安装后，后续换npm安装完成后，启动完成但是打开`stf`界面没有画面显示

    - 这个还是因为`cnpm`的问题，在使用`cnpm`安装的时候会执行`gulp webpack:build `执行完成后会导致启动stf的时候不会执行这个了，所以界面显示为空白

    - 删掉stf目录，重新在`GitHub`上拉取

  - 启动的时候报一堆`module not found`的错

    - 没有安装`bower`

      - `npm install bower -g`

      - 来到stf根目录下

      - `bower install --allow-root`

  - 报`node-sass`问题
    - `npm install node-sass`

## 二、npm安装

- 全局安装
  - `npm install stf -g`
    - 任何位置都可以使用 stf命令

- 非全局安装
  - `npm install stf`
    - 需要添加软连
      - 进入到安装目录中的bin目录下，将stf这个文件添加软件到`/usr/local/bin`下

- 如出现报错，按以上解决方法解决即可

## 三、启动STF

- 启动`rethinkdb`

  - 默认端口启动
    - `rethinkdb`

  - 指定端口启动
    - `rethinkdb --bind all --cache-size 8192 --http-port 8090`

- 添加软连（非必要操作）
  - `ln -s stf/bin/stf /usr/local/bin`
    - `stf local`

- 进入到`stf/bin`
  - `./stf local`

- 其他启动方式

  - 使其他用户能访问

    - `./stf local --public-ip 172.19.66.32 --allow-remote`

    - `stf local --public-ip 172.19.66.32 --allow-remote`

    - 访问方式
      - http://172.19.66.32:7100
        - 地址中的IP为启动机器IP
