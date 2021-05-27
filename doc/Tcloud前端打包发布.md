> 看到群里有小伙伴在问怎么打包发布，和一些相关的配置，这里就简单的说一下我自己这边的打包发布的流程吧，我这里基本是在Mac上操作打包的，然后发布到Linux服务器上

## 一、怎么打包？

> 打包很简单，在项目的目录下运行`npm run dev`即可，但要注意一些配置

1. 我们可以在package.json文件中看到以下代码，这其中的`dev`，`start`，`build`，`test`就代表着启动的方式

   ```json
     "scripts": {
       "dev": "webpack-dev-server --inline --progress --config build/webpack.dev.conf.js",
       "start": "npm run dev",
       "build": "node build/build.js",
       "test": "node build/build-test.js"
     },
   
   ```

   - `dev`对应着启动命令`npm run dev`，这个是启动开发环境的，对应的配置就是`dev.env.js`
   - `start`这里就相当于`npm run dev`
   - `build`这里就是打正式包的命令了，对应着启动命令`npm run build`，对应的配置就是`prod.env.js`
   - `Test`这里是打的测试包，对应着启动命令`npm run test`，对应的配置就是`test.env.js`

   *所以这里我们需要注意在不同的启动命令下，生效的是哪个配置文件*

2. 这里我们只讲打的正式包（打测试包操作类似，只是生效的是`test.env.js`文件，注意修改配置即可），打包之前有个注意的点就是我们得修改一下配置，详情请见[打包后样式丢失](https://www.cnblogs.com/yjiangling/p/12922314.html)，否则会出现样式丢失或组件加载不出来等问题

3. 执行完`npm run build`后我们可以在项目文件夹下看到`dist`文件

   ```
   ├── LICENSE
   ├── README.md
   ├── build
   ├── config
   ├── dist     --这个就是打包生成的文件夹
     └── build
         ├── index.html
         └── static
   ├── index.html
   ├── node_modules
   ├── package-lock.json
   ├── package.json
   ├── src
   └── static
   ```

   我们进入`dist`文件夹中可以看到目录结构，而我们要用到的就是以下这两个

   ```
         ├── index.html
         └── static
   ```

## 二、怎么发布到Linux上

> 这里我们用的是centos系统，其他系统类似，无非就是安装Nginx和Apache的区别，centos上安装Nginx或Apache较为的简单，`yum install nginx` 或`yum install httpd`这里我们就用Nginx的方法来发布

1. 验证Nginx是否安装成功，我们可以使用浏览器，通过Linux服务器的IP访问Nginx的测试页面，有看欢迎页即可

2. 安装好Nginx后将我们打好的包上传至Linux服务器中Nginx网站的根目录下，上传我们可以用到一些ssh工具，例如`xshell`或者`FinalShell`都可以，推荐使用`FinalShell`

3. 怎样才能找到我们Nginx的根目录呢，其实在Nginx的配置文件中就体现出来了，找到我们的Nginx配置文件，如果是通过`yum`安装的Nginx那么我们可以在`/etc/nginx/nginx.conf`这里找到，打开配置文件，我们一般会看到下面这个

   ```
   server {
       listen       80;
       server_name  localhost;
       location / {
       root   html;            # 这个root后面就是路径
       index  index.html index.htm;
       }
       error_page   500 502 503 504  /50x.html;
       location = /50x.html {
       root   html;
       }
     }
       #上面这个就是一个完整的server，如果不清楚怎样配置可以再去网上了解下
   ```

   这里的`html`其实绝对路径是`/var/www/html`，所以如果你就想默认这样，那只需要删掉这个`html`路径下所有文件，将刚打包好的这两个放到`/var/www/html`目录下即可

   ```
         ├── index.html
         └── static
   ```

   *如果我们的Nginx还有做一些其他的事情的话，例如端口转发，记得端口占用问题，不要共用一个端口，Nginx也最好设置开机自启，`systemctl enable nginx`*

## 三、怎么访问

因为我们通过80端口来监听的，所以不使用域名的情况下，直接在浏览器中输入Linux的IP就可以访问

## 四、附带一份我这里用的完整的配置

```
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   1800;
    types_hash_max_size 2048;
    client_max_body_size 2048M;
    fastcgi_connect_timeout 300s;
    fastcgi_send_timeout 300s;
    fastcgi_read_timeout 300s;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;

    server {
    listen 8088;    #因为这里是后端服务的端口，我这里没用80，用的8088，这个可以自行更改
    server_name 这里请改成你自己服务器的IP或者域名;

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

    server {
        listen       80;
        server_name  这里请改成你自己服务器的IP或者域名;
        root  html;
        location / {
          index  index.html index.htm;
        }
        error_page  404              /404.html;

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }

}


```

