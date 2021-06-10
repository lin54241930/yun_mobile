> 以下步骤都是按照顺序写的，所以可以一步一步按照顺序来执行

## 一、源码安装编译环境

1. `yum -y groupinstall "Development tools"`
2. `yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel `
3. `yum install libffi-devel -y`

## 二、Python环境

1. 下载安装包
   - 通过官网下载包
     - https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tar.xz
     - 下载到本地再上传至服务器
   - 通过wget命令下载
     - `wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tar.xz`
2. 解压并进入解压后的目录中
   1. `tar -xvf Python-3.9.2.tar.xz`
   2. `cd Python-3.9.2`
3. 进行编译安装
   1. `./configure`
   2. `make && make install`
4. 检验安装
   1. `python3 --version`
      - 输出`Python 3.9.2`
   2. `pip3 --version`
      - 输出pip 20.2.3 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)

## 三、Java环境

以我的系统为例，自带Java8，如果没有Java环境，请自行安装

- 查看Java版本
  - `java -version`
  - 输出openjdk version "1.8.0_282"
  - `javac -version`
    - 如提示“bash: javac: 未找到命令...”
    - `yum install java-devel`
    - 安装完成后再次执行`java -version`
    - 输出javac 1.8.0_282

## 四、NodeJS环境

1. 下载安装包
   1. 去官网下载包
      - https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz
      - 下载到本地再上传至服务器
   2. 通过wget命令下载
      - `wget https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz`
2. 解压
   - `tar -xvf node-v14.16.0-linux-x64.tar.xz`
3. 移动自`/usr/local`
   - `mv node-v14.16.0-linux-x64 /usr/local/`
4. 改一下文件夹名字，方便添加软连
   - `mv node-v14.16.0-linux-x64 nodejs`
5. 添加软链
   - `ln -s nodejs/bin/npm /usr/local/bin/npm`
   - `ln -s nodejs/bin/node /usr/local/bin/node`
6. 检验安装
   - `node -v`
   - 输出 v14.16.0
   - `npm -v`
   - 输出 6.14.11
7. 安装切换`nodejs`版本的工具
   - `npm install n -g`
8. 安装指定版本
   - `n v8.9.3`
9. 切换`nodejs`版本
   - n
   - 通过方向键选择后并回车键确认

## 五、Nginx

1. yum安装（推荐yum安装，以便后续更新）

   1. 如果可以直接通过命令`yum install nginx`安装，则无需下面步骤

   2. 添加源

      - `cd/etc/yum.repos.d/`

      - `vim nginx.repo`

      - 输入“i”

      - 添加以下内容，具体详情请见官网 http://nginx.org/en/linux_packages.html#RHEL-CentOS

      - ```
        [nginx-stable]
        name=nginx stable repo
        baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
        gpgcheck=1
        enabled=1
        gpgkey=https://nginx.org/keys/nginx_signing.key
        module_hotfixes=true
        
        [nginx-mainline]
        name=nginx mainline repo
        baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
        gpgcheck=1
        enabled=0
        gpgkey=https://nginx.org/keys/nginx_signing.key
        module_hotfixes=true
        ```

      - 按esc退出编辑模式

      - 输入":wq"保存

   3. 检验源

      - `yum search nginx`
      - `如有输出则代表安装源成功`

   4. 开始安装

      - `yum install nginx`

   5. 检验安装

      - `nginx -v`
      - 输出 `nginx version: nginx/1.18.0`

2. 源码安装

   1. 下载安装包
      1. 去官网下载包
         - http://nginx.org/download/nginx-1.19.8.tar.gz
         - 下载到本地再上传至服务器
      2. 通过wget命令下载
         - `wget http://nginx.org/download/nginx-1.19.8.tar.gz`
   2. 解压并进入解压后的目录中
      - `tar -xvf nginx-1.19.8.tar.gz`
      - `cd nginx-1.19.8`
   3. 进行编译安装
      - `./configure`
      - `make && make install`
   4. 添加软链
      - `ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx`
   5. 检验安装
      - `nginx -v`
      - 输出 nginx version: nginx/1.19.8

## 六、MySQL安装

详情请见MySQL安装教程 [CentOS7安装MySQL教程](https://github.com/lin54241930/yun_mobile/blob/main/doc/CentOS7%E5%AE%89%E8%A3%85MySQL8.0.pdf)

