
<map>
  <node ID="root" TEXT="STF部署 (4)">
    <node TEXT="云真机部署" ID="DylPJfb9aV0B6K1LkBIMHJ6XhXW67409" STYLE="bubble" POSITION="right">
      <node TEXT="Linux部署（以centos 7.9为例）" ID="v889oMTSuWXqGOOGW0W3X6zMZfi67410" STYLE="fork">
        <node TEXT="环境准备（所有环境都是在root下安装）" ID="mygycT87DKpVxrTZfqfuOQSnhfD67411" STYLE="fork">
          <node TEXT="源码安装编译环境" ID="Ii24dNBFPfSAFfZ4YEowo0LjtLg67412" STYLE="fork">
            <node TEXT="yum -y groupinstall &quot;Development tools&quot;" ID="F8Y1GnWPoBltEInfJjHM8gWsmB767413" STYLE="fork"/>
            <node TEXT="yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel" ID="xFdlvEkN8RQ5EFwnmiUQGvK9vEK67414" STYLE="fork"/>
            <node TEXT="yum install libffi-devel -y" ID="vL8tJlpW4wRiF1EkdvkVl3ZLLys67415" STYLE="fork"/>
          </node>
          <node TEXT="Python" ID="aahJEV1avnIzh6JErDyEC0TU9Qg67416" STYLE="fork">
            <node TEXT="下载安装包" ID="TLls51KzQcCFdBKhNMAOlXxdEwb67417" STYLE="fork">
              <node TEXT="去官网下载包" ID="cswSySpqUvvGw05Mzlnq7dqgQLb67418" STYLE="fork">
                <node TEXT="https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tar.xz" ID="Yif2HgGXLijj6QUn1DbYxkTcg7w67419" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="PIR1ZWZRO1sAGGxdL9nft6Vmb8067420" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="y79tKnX480ZwXqstuyeepBXIzFY67421" STYLE="fork">
                <node TEXT="wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tar.xz" ID="bG31cYYFnrWE6Rh4vnqqeB24ZB867422" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="解压并进入解压后的目录中" ID="sjDvnv7VBzyZrSQG2YsYknTKZq567423" STYLE="fork">
              <node TEXT="tar -xvf Python-3.9.2.tar.xz" ID="7xVeR8PnUcU0ZtXotbzO19tByaZ67424" STYLE="fork"/>
              <node TEXT="cd Python-3.9.2 " ID="WyK0sLeLWM6EuLn8TadHhZ7w61R67425" STYLE="fork"/>
            </node>
            <node TEXT="进行编译安装" ID="C2uHaZhTB39gOIfXMziCLc1WfFP67426" STYLE="fork">
              <node TEXT="./configure" ID="Mzs94Ptv4wIZjWWomcfeeqSf25c67427" STYLE="fork"/>
              <node TEXT="make &amp;&amp; make install" ID="MxTntnGZi9kVDwy33AUVHjTPqpf67428" STYLE="fork"/>
            </node>
            <node TEXT="检验安装" ID="KWam6axBef1wqyhYmD84iTu7zUk67429" STYLE="fork">
              <node TEXT="python3 --version" ID="AJ9Na5g684fpRiJQY0gCvRs7Zyb67430" STYLE="fork">
                <node TEXT="输出Python 3.9.2" ID="AAksDZusQmn4qC4igaHDGpaqb2t67431" STYLE="fork"/>
              </node>
              <node TEXT="pip3 --version" ID="yoiMnOJU2WVimpMfYEPpeSkaZGT67432" STYLE="fork">
                <node TEXT="输出pip 20.2.3 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)" ID="Lf3tgGsu5TVOSVyIr1y855JHioc67433" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="Java" ID="RojwLp3FZaD7PCgZwbb4Qm4TJ7P67434" STYLE="fork">
            <node TEXT="以我的系统为例，自带Java8" ID="vcVBWfoqvxdH2KKtL4uPYAhDqJe67435" STYLE="fork">
              <node TEXT="查看Java版本" ID="tezVHeNqTJfbaGW02IB5lotziFA67436" STYLE="fork">
                <node TEXT="java -version" ID="M3a2shQzAA1GfeIpnFIM7jI3Gvh67437" STYLE="fork">
                  <node TEXT="输出openjdk version &quot;1.8.0_282&quot;" ID="HqqfRMJunsJRCv5TgaW4KqipRaV67438" STYLE="fork"/>
                </node>
                <node TEXT="javac -version" ID="72HmtOZ53sL5tTfK1mX4bXfUyHH67439" STYLE="fork">
                  <node TEXT="如提示“bash: javac: 未找到命令...”" ID="ib5ljY66CtIFfqRo9fJmq88ZvY867440" STYLE="fork">
                    <node TEXT="yum install java-devel" ID="4kJTWKxQqKhBwmkEFJwU7sUXJff67441" STYLE="fork">
                      <node TEXT="安装完成后再次执行java -version" ID="5psazfhGFV89qK0drKbXtEpFt1O67442" STYLE="fork">
                        <node TEXT="输出javac 1.8.0_282" ID="wSCTCjUnCNDdStV0og5m6G75BE767443" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="NodeJS" ID="IQEqDyWnkJdE9OMREtXuPzuL08I67444" STYLE="fork">
            <node TEXT="下载安装包" ID="Z9lRAmNwfqo6EEYDf5ZS03nxAJv67445" STYLE="fork">
              <node TEXT="去官网下载包" ID="hqfrGxd46yokPlJ5SL6Q6thfmq367446" STYLE="fork">
                <node TEXT="https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz" ID="e33WAY1CIq5IzXcYe9bzpEwdWdP67447" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="3C9RC8wOUdAmimR4aeQx4w6RF5667448" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="45FHkj5FPUiJgvDW3hzsQ1zUWyP67449" STYLE="fork">
                <node TEXT="wget https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz" ID="v44tpizJPm9GDuc8LiMNf0uJ3Kw67450" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="解压" ID="1ZbDfCAeBmeNZZwGHpOblL87Wiv67451" STYLE="fork">
              <node TEXT="tar -xvf node-v14.16.0-linux-x64.tar.xz" ID="0dAHvwstJngzdJTAy9jFOhZJ1hV67452" STYLE="fork"/>
            </node>
            <node TEXT="移动自/usr/local" ID="cSKx6dnsL0k8YdLcUwZQGWJsIxI67453" STYLE="fork">
              <node TEXT="mv node-v14.16.0-linux-x64 /usr/local/" ID="DUmRxi42GlwmbL3qyaDnl0qKQQa67454" STYLE="fork"/>
            </node>
            <node TEXT="改一下文件夹名字，方便添加软连" ID="LnGEZJ6tFXwWh7lF7djGx2JTSgs67455" STYLE="fork">
              <node TEXT="mv node-v14.16.0-linux-x64 nodejs" ID="6pUiXlvKeVltKeJ9SssVp60IB5S67456" STYLE="fork"/>
            </node>
            <node TEXT="添加软连" ID="Cpxnd6NX0VkQfBUtx9eCzG7CkxW67457" STYLE="fork">
              <node TEXT="ln -s nodejs/bin/npm /usr/local/bin/npm" ID="EHA67WOcn7fEs3BRfwjWDKfkGew67458" STYLE="fork"/>
              <node TEXT="ln -s nodejs/bin/node /usr/local/bin/node" ID="z39NFJ2HKFWtu3Kqw5bSO73RFP667459" STYLE="fork"/>
            </node>
            <node TEXT="检验安装" ID="CWa9MOAH0DoiCO44H2VsM7gXP6f67460" STYLE="fork">
              <node TEXT="node -v" ID="7DKcWdmDTY5MgmQFkZtFsQD4OC167461" STYLE="fork">
                <node TEXT="输出 v14.16.0" ID="c2vlaFTsKnZq5wJj3bwDeT9vUf767462" STYLE="fork"/>
              </node>
              <node TEXT="npm -v" ID="QF2sz6WflmWH8ntG6IXsloBWygM67463" STYLE="fork">
                <node TEXT="输出 6.14.11" ID="1anlrgZYb1MVyBKDWBFQRigu8Rv67464" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="安装切换nodejs版本的工具" ID="R2AtwC8B8JXEL1PU1YW0yTubdAn67465" STYLE="fork">
              <node TEXT="npm install n -g" ID="LgOmthnBtAmT32jpCkFOPNDCJ8w67466" STYLE="fork"/>
            </node>
            <node TEXT="安装指定版本" ID="mWw4l1cNBwW9CjYzqvPlDs1VNJg67467" STYLE="fork">
              <node TEXT="n v8.9.3" ID="hacIEq4aklK6Cv2Htfntznu144G67468" STYLE="fork"/>
            </node>
            <node TEXT="切换nodejs版本" ID="niolaXS90h38G8uyZlmxHUiUPAN67469" STYLE="fork">
              <node TEXT="n" ID="SLlL7KyplMDctrVJEGaeROGlswj67470" STYLE="fork">
                <node TEXT="通过方向键选择后并回车键确认" ID="G8nmrfgqidjY48QW18YqFgzLxRx67471" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="Nginx" ID="sw3tCXc9eLmgbtu9Y8BDTj0nxNZ67472" STYLE="fork">
            <node TEXT="yum安装（推荐yum安装，以便后续更新）" ID="7lR9qQFxBGj3QYHh1GiHUzMAcyW67473" STYLE="fork">
              <node TEXT="添加源" ID="2UtqZyEbn4VuxL89jfam2oc5Ssb67474" STYLE="fork">
                <node TEXT="cd/etc/yum.repos.d/" ID="Zp1ZjdhMBPCpFauuwW7mpF0T2ro67475" STYLE="fork"/>
                <node TEXT="vim nginx.repo" ID="ZMfgeF3pYNiZiXLnTPGGnl7l8Om67476" STYLE="fork"/>
                <node TEXT="输入“i”" ID="Mw3xzSpmqVBpFFvjYViuZtg9pj367477" STYLE="fork">
                  <node TEXT="添加以下内容，具体详情请见官网 http://nginx.org/en/linux_packages.html#RHEL-CentOS" ID="7nmuuSgH8X0zMPuvMY3Z0CmUQdd67478" STYLE="fork"/>
                  <node TEXT="[nginx-stable]name=nginx stable repobaseurl=http://nginx.org/packages/centos/$releasever/$basearch/gpgcheck=1enabled=1gpgkey=https://nginx.org/keys/nginx_signing.keymodule_hotfixes=true[nginx-mainline]name=nginx mainline repobaseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/gpgcheck=1enabled=0gpgkey=https://nginx.org/keys/nginx_signing.keymodule_hotfixes=true" ID="LcwPLiJeYAJ58GydvICMgnt2Iwt67479" STYLE="fork"/>
                </node>
                <node TEXT="按esc退出编辑模式" ID="K4jZ0VjOP9JSIfR1y2GsQxl5q6m67480" STYLE="fork"/>
                <node TEXT="输入&quot;:wq&quot;保存" ID="1lxbqjZcvy6xKT0bTwF3PH3zJ1P67481" STYLE="fork"/>
              </node>
              <node TEXT="检验源" ID="hf3vHTiHY2P1SZdlChWyPAhhCAb67482" STYLE="fork">
                <node TEXT="yum search nginx" ID="CPF8hkUv6DmFTrEAaBtnicDXj3U67483" STYLE="fork">
                  <node TEXT="如有输出则代表安装源成功" ID="0ee2o7RP9GYZ65x27hMcGSI2MhA67484" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="开始安装" ID="CLfaUEddmNHRVt3IA4BqbrImn7f67485" STYLE="fork">
                <node TEXT="yum install nginx" ID="u7tFIHCDeXVczj9EhbESMPI7hGV67486" STYLE="fork"/>
              </node>
              <node TEXT="检验安装" ID="SsglbTmQ7Suforsd80V6wqeW80867487" STYLE="fork">
                <node TEXT="nginx -v" ID="ed24jm2mlrVIlKOA9YK9zuyktqX67488" STYLE="fork">
                  <node TEXT="输出 nginx version: nginx/1.18.0" ID="8AQ6PlDxWlX4430FKUfIvbgbu3k67489" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="源码安装" ID="H5UeRECsXfzzpY1UXwqCb1MzCWA67490" STYLE="fork">
              <node TEXT="下载安装包" ID="tNQhIZKNMZeycuP7ca9LDEjRPJI67491" STYLE="fork">
                <node TEXT="去官网下载包" ID="ezOBCBbC9bxzNHNdLk5aGhlqKIH67492" STYLE="fork">
                  <node TEXT="http://nginx.org/download/nginx-1.19.8.tar.gz" ID="ykOgXTX3YfWAU1MfN6Op2LzAaI567493" STYLE="fork">
                    <node TEXT="下载到本地再上传至服务器" ID="8YW8aCFEGDmZeov7x7YjqZX19Tv67494" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="通过wget命令下载" ID="hoyJkQ1eCyJ8LMcNAryeBa5tuxk67495" STYLE="fork">
                  <node TEXT="wget http://nginx.org/download/nginx-1.19.8.tar.gz" ID="3neao8AfsaPNTY71I9aVmZXGjdT67496" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="解压并进入解压后的目录中" ID="nOc6ADnx4qIz4tFpqMroLvT7NT467497" STYLE="fork">
                <node TEXT="tar -xvf nginx-1.19.8.tar.gz" ID="CvE8jmuZlUoKNUvB13gcmIWStRg67498" STYLE="fork"/>
                <node TEXT="cd nginx-1.19.8" ID="eLQWevrarXELGIA8Axv8eDC5BWQ67499" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="YmiClpdlVMPggHWJttLddzy9Ayo67500" STYLE="fork">
                <node TEXT="./configure" ID="7pnrPOfklDBZd0IJkzpVp5kmIry67501" STYLE="fork"/>
                <node TEXT="make &amp;&amp; make install" ID="mVeXazSX3blGEgB7HL837Tho81G67502" STYLE="fork"/>
              </node>
              <node TEXT="来到/usr/local/nginx/sbin" ID="CIdyYh5ud3t5CXWsccyLgkX6gjr67503" STYLE="fork"/>
              <node TEXT="检验安装" ID="9TZEBYWPEfmHqCfgTd0OOXjeZO167504" STYLE="fork">
                <node TEXT="./nginx -v" ID="md7xi5zS7iPbIjVqVs5tVDRWOYU67505" STYLE="fork">
                  <node TEXT="输出 nginx version: nginx/1.19.8" ID="75tERzrAMxxw3NZ6Yt8AWiCiY1M67506" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="MySQL" ID="OeYFypNtmpij0jihCx2CXM9smPy67507" STYLE="fork">
            <node TEXT="步骤较多，详情请见文档" ID="QACF73iK5Qns7QQhAcgBGtagVua67508" STYLE="fork">
              <node TEXT="​CentOS7安装MySQL8.0图文教程​ " ID="BtxppGI3bxq6TxbV3J0UoC0GT0w67509" STYLE="fork"/>
            </node>
          </node>
        </node>
        <node TEXT="搭建STF" ID="4aXYgm7KD7tTS2rhLe4wP5C6hTU67510" STYLE="fork">
          <node TEXT="环境准备" ID="m9y59uZhmzOJzKz15x2X4kfl9nq67511" STYLE="fork">
            <node TEXT="cnpm" ID="I4hf8UqmO3q6v0JxutJkc3iHtFn67512" STYLE="fork">
              <node TEXT="国外某些源可能被墙，所以需要安装一个淘宝的源" ID="7WE88NH03E59EVRrcFpVXlKvSaB67513" STYLE="fork">
                <node TEXT="npm install -g cnpm --registry=https://registry.npm.taobao.org" ID="4oDk3JigfMFnVBfddPS5N8Zkv7U67514" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="adb" ID="M1LFhgdyqYDNZlvwASiSt4JReKX67515" STYLE="fork">
              <node TEXT="下载并安装Android Studio来安装 platform-tools" ID="AcGcUSEB91JuDGsZU7HE8ObhiQG67516" STYLE="fork">
                <node TEXT="https://developer.android.google.cn/studio" ID="s7iTdh4xlOBdSAFx2B7EKCaHUSf67517" STYLE="fork"/>
                <node TEXT="安装完成后，找到SDK的目录" ID="xC7g8Rfg9LdAboQl1eqarJJtg2c67518" STYLE="fork"/>
                <node TEXT="添加环境变量" ID="0vTICtKnBplpqNU5BMyqf2l5b4a67519" STYLE="fork">
                  <node TEXT="example：export PATH=$PATH:/root/Android/Sdk/platform-tools" ID="woVOBmJLeeyvb3pvaKDfepqcPqZ67520" STYLE="fork"/>
                </node>
                <node TEXT="source /etc/profile" ID="NsTpnJpQrRLcP2vnGMwvGtVI3U367521" STYLE="fork"/>
              </node>
              <node TEXT="通过下载sdk-tools来安装 platform-tools" ID="ItYeAqtMxwWKSprMD3UFMC42ixm67522" STYLE="fork">
                <node TEXT="wget  https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" ID="opQAGPkImRyB3cwZkEds0KzziVu67523" STYLE="fork"/>
                <node TEXT="unzip ​sdk-tools-linux-3859397.zip​ " ID="zTTBOwH61CWFi0g7wnK3LTh7MCA67524" STYLE="fork"/>
                <node TEXT="添加环境变量 vim /etc/profile" ID="6ezw8OLayAGqEdvdUuOFlwWW7jO67525" STYLE="fork">
                  <node TEXT="export PATH=$PATH:/usr/local/android/tools/bin 这里的目录就是刚才解压后的tools/bin目录" ID="8a8KKsteOLQqsSoAl3VQXlRtuAS67526" STYLE="fork"/>
                </node>
                <node TEXT="source /etc/profile" ID="v7AD56I8ygv7NXrY7YDzucVzNT067527" STYLE="fork"/>
              </node>
              <node TEXT="直接使用附件（除了这个方法不需要VPN以上两种方法都需要VPN）" ID="Nj8ZGAbKGb26GiGC3FTqOcGZdMh67528" STYLE="fork">
                <node TEXT="​platform-tools.zip​ " ID="d6buEtFU52lB99BorqtmgTOylko67529" STYLE="fork">
                  <node TEXT="添加环境变量 vim /etc/profile" ID="ujL4qxMnwa53Kn5OJuzttH4AQx367530" STYLE="fork">
                    <node TEXT="export PATH=$PATH:/usr/local/android/tools/bin 这里的目录就是刚才解压后的tools/bin目录" ID="EFAZHs3QRGJVZmDkqT4mQI27zMd67531" STYLE="fork"/>
                  </node>
                  <node TEXT="source /etc/profile" ID="fP7srRCcpaFx1YUPlH6KNvNdwV467532" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="RethinkDB" ID="JO8CtkqJsp0eJUJzfDuhWAZMs8h67533" STYLE="fork">
              <node TEXT="添加安装源，详情见官网 https://rethinkdb.com/docs/install/centos/" ID="QXy7WPG7M3gm0FKAfp2VKy5cZL767534" STYLE="fork"/>
              <node TEXT="sudo cat &lt;&lt; EOF &gt; /etc/yum.repos.d/rethinkdb.repo[rethinkdb]name=RethinkDBenabled=1baseurl=https://download.rethinkdb.com/repository/centos/7/x86_64/gpgkey=https://download.rethinkdb.com/repository/raw/pubkey.gpggpgcheck=1EOF" ID="u74xVSJc5qCbVNlgmEZAsPiqDyQ67535" STYLE="fork"/>
              <node TEXT="sudo yum install rethinkdb" ID="YKZOz3I4aZ5ZlUP5cpiBibDAIN367536" STYLE="fork"/>
              <node TEXT="检验安装" ID="IN4jXDre43BGai8xBIcjw2w50SV67537" STYLE="fork">
                <node TEXT="rethinkdb --version" ID="gqyGAZsIi0Wq7AilvBtGf2syHjG67538" STYLE="fork">
                  <node TEXT="输出 rethinkdb 2.4.1 (GCC 4.8.5)" ID="FKblNQAqDVbUINIs3NEtWM9R5E967539" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="GraphicsMagick" ID="ZRp5rpO1IrgpnBESDcEYKIdGifY67540" STYLE="fork">
              <node TEXT="去官网下载" ID="FQ3S5Ippcx5STHpS5gN9gEM97rS67541" STYLE="fork">
                <node TEXT="下载最新的 http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/" ID="rQN2mvGrcHmsj9WWNuc3qkWl0Xh67542" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="VrdsqlPRIDxRpLHBi7jFrT7FKNN67543" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="YvXCt3OnInbG7WNXTiYG9xsEiXB67544" STYLE="fork">
                <node TEXT="wget http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/1.3/GraphicsMagick-1.3.36.tar.gz" ID="oxKx1IiyVJsAN0AJm16FklsZrjA67545" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="aw8BWsNiAhk6rEQcwBASwjeeRWB67546" STYLE="fork">
                <node TEXT="tar -xvf GraphicsMagick-1.3.36.tar.gz" ID="XSz5v85QTw0FDGSKMfjmRIRbsaj67547" STYLE="fork"/>
                <node TEXT="cd GraphicsMagick-1.3.36" ID="u6NJcc14TnQBN5Bfl1LYOiq5rUo67548" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="3SZJF0h9F4TdNEZgrMwKWdJsTXN67549" STYLE="fork">
                <node TEXT="./configure" ID="wDfXvXyBimOzs2GwylqMUlaKOUZ67550" STYLE="fork"/>
                <node TEXT="make &amp;&amp; make install" ID="XQ0iKuHgopAYNhY4c3kJ9RbAdUj67551" STYLE="fork"/>
              </node>
              <node TEXT="检验安装" ID="HQkSjahfheNw6RL4dltAPGduoFI67552" STYLE="fork">
                <node TEXT="gm" ID="4JYq0FW7qpFdEbwXJn3mW8jbP6067553" STYLE="fork">
                  <node TEXT="有输出版本代表安装成功" ID="o8ePxirb6VXuzqtcmePutnPM3rC67554" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="libsodium" ID="bNX6Dtlxvv4QManTB23NIz2kz9R67555" STYLE="fork">
              <node TEXT="去官网下载" ID="8TPL0qxwpxLIya1ZJK1bJmVKDcR67556" STYLE="fork">
                <node TEXT="下载最新的 https://download.libsodium.org/libsodium/releases" ID="zuOnSvO3bhOEEuKGcODupnLtUNX67557" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="OrE65ob1upGsbNkNS8h33VWRfLZ67558" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="gYBraAZRBSPq7B0SYVSQ1zNwRUI67559" STYLE="fork">
                <node TEXT="wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18-stable.tar.gz" ID="0smdNwsxtDAbi3YZIfvZ1IMRLfl67560" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="4duwjGyKWdXG3gIZBKSMrXCiJSn67561" STYLE="fork">
                <node TEXT="tar -xvf libsodium-1.0.18-stable.tar.gz " ID="UmlusLP3k8jUmMotVbr0ka144B367562" STYLE="fork"/>
                <node TEXT="cd libsodium-stable" ID="2vjeoX8HSAoDok4H4CF8KfSZ0cQ67563" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="cZ3EUl6a4BhvOpkkrQG2G0bQP8W67564" STYLE="fork">
                <node TEXT="./configure" ID="ZnqDY1uYqEwqLXh0DNfqRKogor467565" STYLE="fork"/>
                <node TEXT="make &amp;&amp; make install" ID="fLadatdUxcedlHcuLv3x6JwS11H67566" STYLE="fork"/>
              </node>
              <node TEXT="验证安装" ID="raJQtvwqVsk8Rdcm0MpumyeSXys67567" STYLE="fork">
                <node TEXT="whereis libsodium" ID="swjNvhroO8rMZOWkohfDqSjn0nu67568" STYLE="fork">
                  <node TEXT="输出 libsodium: /usr/local/lib/libsodium.so /usr/local/lib/libsodium.la /usr/local/lib/libsodium.a" ID="3XuQyrVrMeGwtNjHHvY3JMnZcpc67569" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="ZeroMQ" ID="JDvgMG4woD0CV4f6M8bHjnkSizU67570" STYLE="fork">
              <node TEXT="安装这个之前得先安装libsodium" ID="lvG6ZriB4DbOCYx3XoXSTyPlaqW67571" STYLE="fork"/>
              <node TEXT="去GitHub上下载一个最新的包" ID="H7MHQ3oDuhXfUPvzISqrNHm9Hs667572" STYLE="fork">
                <node TEXT="https://github.com/zeromq/libzmq/releases" ID="I5ClW69J5RuKxltoDM9MT2wkeDh67573" STYLE="fork">
                  <node TEXT="由于后期可能会更新，所以下载最新的.tar.gz包即可" ID="Xf2fjMNLwEnYSYm6gBvJ4VhrvfF67574" STYLE="fork"/>
                  <node TEXT="例如这样的一个包 zeromq-4.3.4.tar.gz" ID="Ba9jP0rCdXk3nAaJngDxTDQwY2s67575" STYLE="fork"/>
                  <node TEXT="下载到本地再上传至服务器" ID="VoLCPuajNmIDcDlxxKMcE7q4b3j67576" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="也可通过wget命令下载" ID="vb1EYdkOkhtn5uUNhOOliSYom0267577" STYLE="fork">
                <node TEXT="wget https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz" ID="ks3vy6w3jKYY0zGPzXKTLFbaAQv67578" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="ZndOXDzTlD3Z5e0f8catx9jwrZs67579" STYLE="fork">
                <node TEXT="tar -xvf zeromq-4.3.4.tar.gz" ID="X4oyeZF9ryqcyN1zaisWaE6XOwE67580" STYLE="fork"/>
                <node TEXT="cd zeromq-4.3.4" ID="DmKtNI9TnaQOBqLbnFDXdzLJZWU67581" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="8hSAZDGpOUvn0YHg0j69qS3nSCc67582" STYLE="fork">
                <node TEXT="./configure" ID="FrMYzBnFQYtlczY0RK29x6YOHAB67583" STYLE="fork"/>
                <node TEXT="make &amp;&amp; make install" ID="VASI8NFgn4tn2gibsNP6FNRnQBc67584" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="protobuf" ID="SJzKA7DY0vHP1kzFNyEuXv6hhcP67585" STYLE="fork">
              <node TEXT="去GitHub上下载一个最新的包" ID="2Iww2Um2k7k0dUDeffTCUPLUDcr67586" STYLE="fork">
                <node TEXT="https://github.com/protocolbuffers/protobuf/releases" ID="wnKlP4kYo8CrdrJt7QMKKc0NiHm67587" STYLE="fork">
                  <node TEXT="由于后期可能会更新，所以下载最新的.tar.gz包即可" ID="EYD6GskjsMrLOdH9LPhNQh60QuR67588" STYLE="fork"/>
                  <node TEXT="例如这样的一个包 protobuf-cpp-3.15.5.tar.gz" ID="NihsrLVG9pTmju8P4rLDA4TSgbI67589" STYLE="fork"/>
                  <node TEXT="下载到本地再上传至服务器" ID="BmsHrRSKbx40YRHSAxOAHg5zo4L67590" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="也可通过wget命令下载" ID="KQ2UAlSFZwRJEUJ3giCj7q9S3cu67591" STYLE="fork">
                <node TEXT="wget https://github.com/protocolbuffers/protobuf/releases/download/v3.15.5/protobuf-cpp-3.15.5.tar.gz" ID="gBzEdUkMZGCb7f0verX3QuNpuYp67592" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="8GXOBsgWWeYqSORRFVram7KISAL67593" STYLE="fork">
                <node TEXT="tar -xvf protobuf-cpp-3.15.5.tar.gz" ID="eBwhyLBFBYoM08uNY9eRrhmD2Ka67594" STYLE="fork"/>
                <node TEXT="cd protobuf-3.15.5" ID="maTK80yhuLFsApSBEvMWfKlrdEA67595" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="IAtPSgn4pHhYohde8UZ1ZnggMES67596" STYLE="fork">
                <node TEXT="./configure --prefix=/usr/local/protobuf" ID="XgG5RrnLkKrCMcBkIwrzt0F4fml67597" STYLE="fork">
                  <node TEXT="注意这步与上面不一样，需要指定路径，方便配置环境变量" ID="tpKSBbZjiRhtfm7ANuBT84ayThD67598" STYLE="fork"/>
                </node>
                <node TEXT="make &amp;&amp; make install" ID="c2nv3r7waXQbImwl840ne3U1pWn67599" STYLE="fork"/>
              </node>
              <node TEXT="配置环境变量" ID="9WXpaO0jPh7aypq2meX7A8kFd6767600" STYLE="fork">
                <node TEXT="vim /etc/profile" ID="5RlIzUDdv2eP0Q7QHHGNaYV9of667601" STYLE="fork"/>
                <node TEXT="输入“i”" ID="4sDqK3aldRbY8xgtLesUAnzfFma67602" STYLE="fork"/>
                <node TEXT="export PATH=$PATH:/usr/local/protobuf/bin/" ID="wwyq9UWdwdKrSzLBgCzMOMjbVl867603" STYLE="fork"/>
                <node TEXT="export PKG_CONFIG_PATH=/usr/local/protobuf/lib/pkgconfig/" ID="DK9Ufsv8ujCxTx3TJsqEx3KUFmz67604" STYLE="fork"/>
                <node TEXT="输入“wq!”" ID="I0bFg28Y3T87VlSlmsd09CUI3wZ67605" STYLE="fork"/>
                <node TEXT="source /etc/profile" ID="9EqtBAkWecMXgazf0m0N8n5qKgu67606" STYLE="fork"/>
              </node>
              <node TEXT="验证安装" ID="3QjJ6KLEjKCVUjjlX9sksr38NEn67607" STYLE="fork">
                <node TEXT="protoc --version" ID="O19Z3cN5feAvGibJQ9t8xU1r2ot67608" STYLE="fork">
                  <node TEXT="输出 libprotoc 3.15.5" ID="utTqVXnTd19nnmxrGmpr0ntRu7s67609" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="yasm" ID="8qtZJI8mMLAuDJ8cw6uHxqU0R7R67610" STYLE="fork">
              <node TEXT="去官网下载" ID="SdSS97zO1E3ZSZ6hiwCAlOd3ieE67611" STYLE="fork">
                <node TEXT="下载最新的 http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz" ID="w29tce1PW3CmzMkBfFlCXEpDny767612" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="mcL2l88n0tCBXviTrkX6fzgDvW467613" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="DpnTmq0DBlbFMT7tcfO3cpj7fR767614" STYLE="fork">
                <node TEXT="wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz" ID="DPOaVcuJNwr0igLT7rNAn8e51Lv67615" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="UoE53zQJl3NNVYyLs50AZBKx96z67616" STYLE="fork">
                <node TEXT="tar -xvf yasm-1.3.0.tar.gz" ID="d4sb28ao6oE1VY6N4skvpV58SDw67617" STYLE="fork"/>
                <node TEXT="cd yasm-1.3.0" ID="Gg1kL6dMwfjTPh38620ecQNMTqJ67618" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="eBzpsVnieCDRR5D2soR38Kas0g367619" STYLE="fork">
                <node TEXT="./configure" ID="4sbDR2rJlcC872UlBIltqLwNS7m67620" STYLE="fork"/>
                <node TEXT="make &amp;&amp; make install" ID="ZGEnPM1bi6Iggd1ev9Jn2MwcZTp67621" STYLE="fork"/>
              </node>
              <node TEXT="验证安装" ID="NzKy3uGf92fRpJjvatndZ8T4OY367622" STYLE="fork">
                <node TEXT="yasm --version" ID="MyryaSCrtLA4AFtjcPN5xs7umht67623" STYLE="fork">
                  <node TEXT="输出 yasm 1.3.0" ID="ANJk4b3jk91Pqd8niSulB0SnosD67624" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="pkg-config" ID="tjQQgGJjMHo7GVxQFUM4FiM8x4E67625" STYLE="fork">
              <node TEXT="去官网下载" ID="LkJvWqROSZCHaqv3TNdVbtRB7E567626" STYLE="fork">
                <node TEXT="下载最新的 http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz" ID="dYiFs5I6S23tWl05ClQcoomx0Zs67627" STYLE="fork">
                  <node TEXT="下载到本地再上传至服务器" ID="IZS6r1rmYUP3dqvdKFJrYdoYO1X67628" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过wget命令下载" ID="qGHzClyQYO1t6HFaOKMb09OID5M67629" STYLE="fork">
                <node TEXT="wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz" ID="kA1eTt6h5zv0zp8g1YwpOBIZeb467630" STYLE="fork"/>
              </node>
              <node TEXT="解压并进入到目录中" ID="3Qb8aLSKMscFxdK7BUcT2Wpa8Sx67631" STYLE="fork">
                <node TEXT="tar -xvf pkg-config-0.29.2.tar.gz" ID="wj69XczqYyIftmhSJ0diNaYzDvN67632" STYLE="fork"/>
                <node TEXT="cd pkg-config-0.29.2" ID="VaxS365yKDiyDriryArJENHzpXt67633" STYLE="fork"/>
              </node>
              <node TEXT="进行编译安装" ID="syK4nkGSo7zyLvRzFiCjGpnblp867634" STYLE="fork">
                <node TEXT="./configure --prefix=/usr/local/pkg-config --with-internal-glib" ID="H2S8CsOU6mEiMJkrXQZNgNxfTKB67635" STYLE="fork">
                  <node TEXT="这里也需要指定路径" ID="PX45gNLtFvhM3g5viQsTpPhl8Dt67636" STYLE="fork"/>
                </node>
                <node TEXT="make &amp;&amp; make install" ID="d5grLkRSpOkHaFgJvWh64DGPoFO67637" STYLE="fork"/>
              </node>
              <node TEXT="验证安装" ID="MTAaMstxfxoKnIpRwxNym5sJYkV67638" STYLE="fork">
                <node TEXT="pkg-config --version" ID="nNnwEfyc66Z5lexzSIjX8TyDbKE67639" STYLE="fork">
                  <node TEXT="输出 0.27.1" ID="ITOKUuDOyf7H59gzJTmdK2D5twg67640" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="CMake" ID="gja4Ppl0yFCdaqg7Ab0ZbovEMeg67641" STYLE="fork">
              <node TEXT="源码安装" ID="LUZUaafFm2oeAMIDX7SaKxsng6z67642" STYLE="fork">
                <node TEXT="https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4.tar.gz" ID="xRnEwZhMDRqPXffgO6cxLIPm1XK67643" STYLE="fork">
                  <node TEXT="下载下来后传到服务器上" ID="rcXCg878ORSivn6w4T3kwMjThMV67644" STYLE="fork"/>
                </node>
                <node TEXT="通过 wget 命令下载" ID="CUgap55KkSH3oqQehshyhqxRP6V67645" STYLE="fork">
                  <node TEXT="wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4.tar.gz" ID="l2OCJ8DIUdPXWSANz9Gm9M1qEHx67646" STYLE="fork"/>
                </node>
                <node TEXT="解压并进入到目录中" ID="fZJ6AC2LcffPrN00vwqed1MrInL67647" STYLE="fork">
                  <node TEXT="tar -xvf cmake-3.20.0-rc4.tar.gz" ID="UusFFCP3dz4i9854elgllDyXKB867648" STYLE="fork"/>
                  <node TEXT="cd cmake-3.20.0-rc4" ID="ulOa0jH778kK9b2EUYDzNaZ9kvY67649" STYLE="fork"/>
                </node>
                <node TEXT="进行编译安装" ID="bNh1HZ8gRbMyFPGWfHAbej7y4Qu67650" STYLE="fork">
                  <node TEXT="./configure" ID="ZK1T0B00LiNAB0RP0Rt81ZLdSAl67651" STYLE="fork"/>
                  <node TEXT="make &amp;&amp; make install" ID="qp5uG9TjXVjpOIMz0A64oWIdx0N67652" STYLE="fork"/>
                </node>
                <node TEXT="验证安装" ID="omztlNq5IgZMVsE7mn1HQY0Wlny67653" STYLE="fork">
                  <node TEXT="cmake --version" ID="K5mmoOCaxggHopzzu4HDh0QeZLd67654" STYLE="fork">
                    <node TEXT="输出 cmake version 3.20.0-rc4" ID="yCDD6yWz4DmPECdVhRjl1Z9yZah67655" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="使用编译好的(建议使用这个)" ID="8wrVryhuQa8QFguHXY5e23rHjMU67656" STYLE="fork">
                <node TEXT="https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4-linux-x86_64.tar.gz" ID="uecxC0KZZd4ClURiUDripuzPjy967657" STYLE="fork">
                  <node TEXT="下载下来后传到服务器上" ID="2OIKreVq85XX9SeeejSYOWOBqAb67658" STYLE="fork"/>
                </node>
                <node TEXT="通过 wget 命令下载" ID="N6rkNFyQA2gIzxPqCNWJR0o5S7O67659" STYLE="fork">
                  <node TEXT="wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc4/cmake-3.20.0-rc4-linux-x86_64.tar.gz" ID="Bft63m4iGWDuXypeZrnGfOHB4tg67660" STYLE="fork"/>
                </node>
                <node TEXT="解压并进入到目录中" ID="tGYuvAd52KX5danZwt5w3xc155s67661" STYLE="fork">
                  <node TEXT="tar -xvf cmake-3.20.0-rc4-linux-x86_64.tar.gz" ID="o9d7H0CAIwuFAZgCqH4CmDiwDNm67662" STYLE="fork"/>
                  <node TEXT="cd cmake-3.20.0-rc4-linux-x86_64/bin" ID="OzxgHNcootycwf65urwGmzkqa8n67663" STYLE="fork"/>
                </node>
                <node TEXT="添加软连" ID="Au8V6kxNhhVKv0BliKHHH1EGfq167664" STYLE="fork">
                  <node TEXT="ln -s cmake /usr/local/bin/cmake" ID="IobGvLlDZkO8dSE2eHVyEUcqP7M67665" STYLE="fork"/>
                </node>
                <node TEXT="验证安装" ID="do5cIYF9mCwMUx2AQKQ36U5UlX467666" STYLE="fork">
                  <node TEXT="cmake --version" ID="pjZniv3mkDgK7GvB3hn0mL96yXe67667" STYLE="fork">
                    <node TEXT="输出 cmake version 3.20.0-rc4" ID="aNqv4f0SLLgeYgZVvYmP1L9CRLr67668" STYLE="fork"/>
                    <node TEXT="如添加软连后还是不能正确输出版本号，请添加环境变量" ID="YlJXNNsyGZthAtIiBn2Fx9Y4QOT67669" STYLE="fork">
                      <node TEXT="vim /etc/profile" ID="S6i6DGj48v13HxZqb2QNuAek7QJ67670" STYLE="fork">
                        <node TEXT="输如“i”进入编辑模式" ID="7xvNUjO66bODSpp0joicBaDlgmc67671" STYLE="fork"/>
                        <node TEXT="在最后添加 export PATH=$PATH:/usr/local/cmake-3.20.0-rc4-linux-x86_64/bin" ID="7IkmLLUR0JTeuGtQ0XCzVTN99Wl67672" STYLE="fork"/>
                        <node TEXT="按esc退出编辑模式" ID="jICu8Gv1SKqfXvUw94FvsiY9aWr67673" STYLE="fork"/>
                        <node TEXT="输入“:wq!”保存并退出" ID="1WlrWfW33LDRAmayugv94ED1rsm67674" STYLE="fork"/>
                        <node TEXT="source /etc/profile" ID="0Z0gte2ruzaY7cvNkZPDLBODH8R67675" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="安装STF" ID="rc9AqL3FXBtJafRhSqprTlhlBti67676" STYLE="fork">
            <node TEXT="源码安装（推荐）" ID="Tuwr0BDglgm3PNnKjB80PqCIzOH67677" STYLE="fork">
              <node TEXT="去GitHub上手动下载stf源码" ID="JTv24Mu4owQU3nKpapsMtaZ8CPS67678" STYLE="fork">
                <node TEXT="https://github.com/DeviceFarmer/stf" ID="mtnWrXXQd7RtRXwL1jjkn0RBJiZ67679" STYLE="fork"/>
              </node>
              <node TEXT="使用git clone下载到服务器" ID="F6Luyyw8f7oEF2QofrE7rYQqxnc67680" STYLE="fork">
                <node TEXT="git clone https://github.com/DeviceFarmer/stf.git" ID="j3YqorBP8pvGkCKkIcGRdTdQRcT67681" STYLE="fork"/>
              </node>
              <node TEXT="cd stf" ID="6NPTE4bM70J8vvtVMwa5egtyoJG67682" STYLE="fork"/>
              <node TEXT="进行安装" ID="wajL5hJVl63l1SVVYp4naIfolak67683" STYLE="fork">
                <node TEXT="有vpn" ID="wTWvZRtusW99b1ZMtPz4OdFxkc067684" STYLE="fork">
                  <node TEXT="npm install" ID="H2NH2CC6ww4fVWyCrbAwme4iLjR67685" STYLE="fork">
                    <node TEXT="如出现与python相关的报错，则需要安装python2（这里只在centos8上的系统遇到过）" ID="LclTIPXX6tP5X3egaVzqbGGO6Mm67686" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="没有vpn请使用cnpm" ID="aOyEce90fhuMi2s0rQwFc8jDyPz67687" STYLE="fork">
                  <node TEXT="cnpm install" ID="bQUpM2EZXSRtj4j8zqmQzOmXWUE67688" STYLE="fork">
                    <node TEXT="如果使用了cnpm就无法使用npm安装" ID="EqH4hq1j2Qa8afLQjNg3FBVCLYi67689" STYLE="fork"/>
                    <node TEXT="使用cnpm安装后如再想使用npm安装则需要删掉项目目录下node_modules文件夹" ID="eU0XsLOiHCEcjxq3xVDeipTGaOH67690" STYLE="fork"/>
                  </node>
                  <node TEXT="用下来发现使用cnpm问题会很多，不建议使用cnpm" ID="vjIinNq9BbHTRu03zy68JlOE9Lk67691" STYLE="fork"/>
                </node>
                <node TEXT="如果执行一次npm install/cnpm install不行的话，就多执行几次" ID="xttsNsqL1fCVRAeMB7B4BgAfkb367692" STYLE="fork"/>
                <node TEXT="安装中如遇到报 “Failed at the @julusian/jpeg-turbo@0.5.6 install script”" ID="m7Sz06eGt11cQ9RuFQdNw8wZm6O67693" STYLE="fork">
                  <node TEXT="单独执行一次 npm install --save @julusian/jpeg-turbo" ID="I8DTb84auPKM8fRwoLymHzOIr7d67694" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="检验安装" ID="N01DDkAUoKgsQmYwrFhWbrfMr0O67695" STYLE="fork">
                <node TEXT="cd bin" ID="GNYQPRkZM460TQ1gv8w5ZD9Pyha67696" STYLE="fork"/>
                <node TEXT="./stf doctor" ID="ejQphHIQP9rFEuKgiWeuh0el4qO67697" STYLE="fork">
                  <node TEXT="如出现zmq的问题" ID="2DTbEv9lOgG3JjGqCHSA5jq2xvc67698" STYLE="fork">
                    <node TEXT="cd ../node_modules/zmq" ID="Law3N8XDGnTt84DHHJpX2Ck0FKp67699" STYLE="fork"/>
                    <node TEXT="npm install --unsafe-perm" ID="8JAO01KQlwRvhm4PzuOZZ2J6iU367700" STYLE="fork"/>
                    <node TEXT="cd ../../bin" ID="TcRUJsJyMwJo21keqrZunjgAMGC67701" STYLE="fork"/>
                    <node TEXT="再次检验安装" ID="DujQKNPOh0vjdi0B2Lk8dP9YVeh67702" STYLE="fork">
                      <node TEXT="./stf doctor" ID="axhLLYZWWEcQcleMyfWeDja2NPz67703" STYLE="fork">
                        <node TEXT="如出现 “Unexpected error checking ZeroMQ: Error: libzmq.so.5: cannot open shared object file: No such file or directory”" ID="6ouTMv42jTZFGOzW8wBxxFkoFhd67704" STYLE="fork">
                          <node TEXT="vim /etc/ld.so.conf" ID="T3Yia4RTO8j7qLAa53N8BD0dKeE67705" STYLE="fork"/>
                          <node TEXT="输出“i”进入编辑模式" ID="lUN6PjZx5IiUpCTPj16ZDW16MjP67706" STYLE="fork"/>
                          <node TEXT="新增一行 /usr/local/lib" ID="w3C4SVevldb286Gq9KTT1JZjgai67707" STYLE="fork"/>
                          <node TEXT=":wq!保存并退出" ID="D1fcbqvQAr767sd5dndxFY2Vnl467708" STYLE="fork"/>
                          <node TEXT="再执行ldconfig" ID="KMlHJUduPMHsJ2fFIPVPJDcwmA267709" STYLE="fork"/>
                          <node TEXT="再次验证安装" ID="6LRYdd09kmpb62k9JOReuLSPu2b67710" STYLE="fork">
                            <node TEXT="输出" ID="B1BkyFrxPFsF8mNJ5CDqIZkxsqQ67711" STYLE="fork"/>
                          </node>
                        </node>
                      </node>
                    </node>
                  </node>
                </node>
              </node>
              <node TEXT="会出现的问题" ID="yvTpInulIqxegHdddsmQ32IQ2tv67712" STYLE="fork">
                <node TEXT="最开始使用cnpm安装，后续又用npm安装，出现卡死，这时需要删掉node_modules后再使用npm安装" ID="lhN59v39PG7JlH7SBzzWnvqld0u67713" STYLE="fork"/>
                <node TEXT="adb" ID="NT9DuDD8iI93bu89hlmxhCN7zaX67714" STYLE="fork">
                  <node TEXT="运行./stf doctor时出现adb的报错 Unexpected error checking ADB: Error: spawn ELOOP" ID="S4N0D0RpF7bXaDdhlAhjHg8COPm67715" STYLE="fork"/>
                  <node TEXT="这个是环境问题，adb需要设置环境变量，不能使用软链" ID="CJh97yBYQWS9v130t5Vm9zMlI8k67716" STYLE="fork"/>
                </node>
                <node TEXT="使用cnpm安装后，后续换npm安装完成后，启动完成但是打开stf界面没有画面显示" ID="CObhAWJqJWUtrX07KjJJEfDf9PE67717" STYLE="fork">
                  <node TEXT="这个还是因为cnpm的问题，在使用cnpm安装的时候会执行gulp webpack:build 执行完成后会导致启动stf的时候不会执行这个了，所以界面显示为空白" ID="cEHgj9nADigAgLU4i3Vxm0CJYVJ67718" STYLE="fork"/>
                  <node TEXT="删掉stf目录，重新在GitHub上拉取" ID="mzzSgrFl2104VWKArxmpEJWaiR067719" STYLE="fork"/>
                </node>
                <node TEXT="启动的时候报一堆module not found的错" ID="5Rj00jdermeJ8qMYcWFTaEsaNA867720" STYLE="fork">
                  <node TEXT="没有安装bower" ID="aqLgT9oP3s4kSeNFoAQ1djNCsrA67721" STYLE="fork">
                    <node TEXT="npm install bower -g" ID="47vhVOrjFsZtPGVQwedWiGlSwYc67722" STYLE="fork"/>
                    <node TEXT="来到stf根目录下" ID="6h2P4K39earKHYVaAQji6kr6Utm67723" STYLE="fork"/>
                    <node TEXT="bower install --allow-root" ID="wfVcQBYMUdUZiNxtjTW58CxLUYn67724" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="报node-sass问题" ID="zLXCoTcs8PiRnmtroYdkxbYT4lV67725" STYLE="fork">
                  <node TEXT="npm install node-sass" ID="0BSSDwNrJBLDvWy0VOuy5fe6esa67726" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="npm安装" ID="g2q6nIMfh6518OuofbcCawSXl4067727" STYLE="fork">
              <node TEXT="全局安装" ID="JZKepORX8AlSVBv1QJohBYeDS2m67728" STYLE="fork">
                <node TEXT="npm install stf -g" ID="PI1oFwtcsJ7lQw6wYCwF0GDQL4h67729" STYLE="fork">
                  <node TEXT="任何位置都可以使用 stf命令" ID="Wg9PIdZJivszDPLlCWmGMfkgKyB67730" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="非全局安装" ID="1DjxEjWPbhcnwN4bUwyB2FMSKxE67731" STYLE="fork">
                <node TEXT="npm install stf" ID="G6hR1j1y1YEft3fGC93vlvgGSpT67732" STYLE="fork">
                  <node TEXT="需要添加软连" ID="Q7UT6ghPBSDfj0LggrO1l9XyZAt67733" STYLE="fork">
                    <node TEXT="进入到安装目录中的bin目录下，将stf这个文件添加软件到/usr/local/bin下" ID="Fbq6QjVPWwdk2qucbeRMcDvGROt67734" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="如出现报错，按以上解决方法解决即可" ID="7az06OFpA3vCkD98qCVs52YCVhz67735" STYLE="fork"/>
            </node>
            <node TEXT="启动STF" ID="abxAbNd7X8DJ5yuDy2EyWMffgpB67736" STYLE="fork">
              <node TEXT="启动rethinkdb" ID="lzpApYmXwSPq1W3UM8n4yQJmt2A67737" STYLE="fork">
                <node TEXT="默认端口启动" ID="yjkkf3WFWrKXUYzdLAzrGcdr8JC67738" STYLE="fork">
                  <node TEXT="rethinkdb" ID="U0OUDmwegPTy1K71LGsG2eAV93L67739" STYLE="fork"/>
                </node>
                <node TEXT="指定端口启动" ID="Ka1eZTuYReS89Dcl32uXx0W2Oz167740" STYLE="fork">
                  <node TEXT="rethinkdb --bind all --cache-size 8192 --http-port 8090" ID="EDR4zRRCWGO5ZzW4FiCxRyA3HHM67741" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="添加软连（非必要操作）" ID="u65brGwKfaPRXJ7N3dYOltRyeo467742" STYLE="fork">
                <node TEXT="ln -s stf/bin/stf /usr/local/bin" ID="Dn4KKN2LHsBbYNE5hFqEfStqrOL67743" STYLE="fork">
                  <node TEXT="stf local" ID="NdPg1pk77vfo4hqvIq1Bxwe96kk67744" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="进入到stf/bin" ID="MCXklvhM7wVwdzTnrdTrJ8AvNGz67745" STYLE="fork">
                <node TEXT="./stf local" ID="Os9YvQEwej1otaXYJkewNwKPLy167746" STYLE="fork"/>
              </node>
              <node TEXT="其他启动方式" ID="LTVcuuJ2u7RtgmbZysMZzwTQI5G67747" STYLE="fork">
                <node TEXT="使其他用户能访问" ID="VrZwwCPr2OIglKzLOdKw2h0rPHo67748" STYLE="fork">
                  <node TEXT="./stf local --public-ip 172.19.66.32 --allow-remote" ID="GIyJvk0QAArJY8BsOvKwUIN8dJJ67749" STYLE="fork"/>
                  <node TEXT="stf local --public-ip 172.19.66.32 --allow-remote" ID="CpYVnCpvJsjTdA6TSB7SYCvTTRC67750" STYLE="fork"/>
                  <node TEXT="访问方式" ID="hAQm17Ex3svW0DN0WCB7t3gXSox67751" STYLE="fork">
                    <node TEXT="http://172.19.66.32:7100" ID="OdL4AJc7hmuisM77zP02UgjO1tl67752" STYLE="fork">
                      <node TEXT="地址中的IP为启动机器IP" ID="XJEzKKxY6gwg2CPijincvATsd0b67753" STYLE="fork"/>
                    </node>
                  </node>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="搭建云平台前端（README.md中也有此部分的详细搭建步骤）" ID="uZFiJqjFbaPD9Vsl9rNIX1xcKId67754" STYLE="fork">
          <node TEXT="安装" ID="jZXUEqEQJVDxqJC6rYCJ1vhnnUu67755" STYLE="fork">
            <node TEXT="官方版" ID="zXQehbkCOduMLFARfLgE9b00QKg67756" STYLE="fork">
              <node TEXT="git clone https://github.com/JunManYuanLong/Tcloud.git" ID="gIa0IFm7YpRgyXCNmfLePn028cs67757" STYLE="fork"/>
            </node>
            <node TEXT="自用版" ID="Qd6xnpAzBqkinQpSlIy1iFDE03Y67758" STYLE="fork">
              <node TEXT="git clone https://github.com/lin54241930/yun_test.git" ID="jkWHm5Dfze7XaMjoIYpasfoH8M367759" STYLE="fork"/>
            </node>
            <node TEXT="cd 到项目目录" ID="hBwKN2sejJXJ1RbyVjVOf2kIAoP67760" STYLE="fork"/>
            <node TEXT="npm install" ID="t3lS8h2el5DL5oXMwrkqPSXmBiG67761" STYLE="fork"/>
            <node TEXT="如速度较慢或安装失败可使用cnpm安装" ID="ZqhsEs7Mj6fj5ess05Y3NPfLmrp67762" STYLE="fork">
              <node TEXT="cnpm install" ID="dMo0cA6LGyMFi9TTFm7aVjQhFS067763" STYLE="fork"/>
            </node>
            <node TEXT="会遇到的问题" ID="a4PNCc8iZknRXiHd5U0Fa0SMSuV67764" STYLE="fork">
              <node TEXT="node-sass" ID="RvevVJf8ia380gVsunTtJhaCEg867765" STYLE="fork">
                <node TEXT="如出现node-sass的报错，执行npm install node-sass即可" ID="2XKemsu7DJ4AYfYAWAfzTn9ny4g67766" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="启动" ID="feXFIMwdUwciKDSuiXgE2TIKRcB67767" STYLE="fork">
            <node TEXT="npm run dev" ID="ZxT35wfw06mgZ7KvPVH0dLji26N67768" STYLE="fork"/>
          </node>
          <node TEXT="访问" ID="WZHEzsuSOt15gTP5WLSrYTikGC467769" STYLE="fork">
            <node TEXT="http://localhost:8081（这里的端口取决于端口占用情况，从8080开始，如果8080端口被占用，则是8081，8081被占用，则是8082以此类推）" ID="iKCHoujjUjWpqSbYmI8JIWAYiDt67770" STYLE="fork"/>
          </node>
          <node TEXT="修改" ID="7aDFLRSnfs11sjtC7q7ugU1hzVv67771" STYLE="fork">
            <node TEXT="所有修改已集成在项目中" ID="aJuv8NmndeY0NSI18N4nyFv5Jtm67772" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="搭建云平台后端（README.md中也有此部分的详细搭建步骤）" ID="qjhOUhYP5XDw93e6wS1jSaDpeOT67773" STYLE="fork">
          <node TEXT="安装" ID="qRUKDXgDr3aoP93JnhUg2i0Cgiw67774" STYLE="fork">
            <node TEXT="官方版" ID="YzuHufqa127Jt1PDPDb0j0Jdxad67775" STYLE="fork">
              <node TEXT="git clone https://github.com/JunManYuanLong/TcloudServer.git" ID="syqjkUKWmUlBVwzDvIYdfrKHZhg67776" STYLE="fork"/>
            </node>
            <node TEXT="自用版" ID="0qnE1FCJjGXCIwgFvxUUM0zGo7s67777" STYLE="fork">
              <node TEXT="git clone https://github.com/lin54241930/TcServer.git" ID="ui0X8B3ANARSyTcOl0EaxtcFy4Y67778" STYLE="fork"/>
            </node>
            <node TEXT="cd到项目目录" ID="CW2HfjLLttHxHgOrRvKjTOPP7Pi67779" STYLE="fork"/>
            <node TEXT="pip3 install -r requirement.txt" ID="gnryuOxJulp6LMCuozmXfI92eWP67780" STYLE="fork">
              <node TEXT="如速度较慢请用阿里云的源" ID="IwONHCXqvxogolmoYQHLGGJnSb167781" STYLE="fork">
                <node TEXT="pip3 install -r requirement.txt -i https://mirrors.aliyun.com/pypi/simple" ID="Qhb98FXl94uYhdAkAv3A1o6upvX67782" STYLE="fork"/>
              </node>
              <node TEXT="安装过程中可能遇到安装mysqlclient的报错" ID="UZgJf44WzEnsN4zuTnlw4knvWGN67783" STYLE="fork">
                <node TEXT="yum install mysql-devel gcc gcc-devel python-devel" ID="9BpQclAtVBdKJaM4CI9s1emfz3O67784" STYLE="fork">
                  <node TEXT="如果安装完成后还是报mysql的错，就需要安装与当前python版本对应的python-devel。例：python3.8 需要yum install python38-devel" ID="JKu1wytktcxtrkvSZ2dUnRx5D0n67785" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="requirement.txt文件中去掉pandas的版本号指定，否则会出现版本兼容的问题导致安装失败，Python3.8以上的版本会出现此问题" ID="o4SPFBcCK0AdVvFLkaNB0YvBgFZ67786" STYLE="fork"/>
            </node>
            <node TEXT="初始化数据库" ID="GsmVq1M2ynCMAN6U1aoLDa5Q8xU67787" STYLE="fork">
              <node TEXT="使用Navicat或其他可视化工具连接上数据库" ID="iAXPcuFpJEd3JSNi8ygO8iTA38V67788" STYLE="fork">
                <node TEXT="将根目录下deploy/init/init.sql导入" ID="uCUabABBr8hvHUMFWubmIDO55zr67789" STYLE="fork"/>
              </node>
              <node TEXT="修改后端根目录下local_config.py 文件中的数据库配置" ID="0jyeE3znxgBHVoEDOG1D3m1AZ7767790" STYLE="fork">
                <node TEXT="SQLALCHEMY_DATABASE_URI = &apos;mysql://root:tc123456@172.19.66.77:3306/demo?charset=utf8&apos;" ID="ZsCBbN0sWgsziie3YWPrGucGKXe67791" STYLE="fork"/>
                <node TEXT="这里对应的就是数据库的用户名，密码，连接地址，端口，连接数据库" ID="FfYC8D70WiZJ6NITVYNSNXRWLvk67792" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="Nginx配置" ID="yuiA8ZrbF0cb8sBoJjmMJAX6mPN67793" STYLE="fork">
              <node TEXT="yum安装" ID="qjTAGS66kR0O4orcFSSX3lG0ca767794" STYLE="fork">
                <node TEXT="nginx.conf文件在/etc/nignx下" ID="i5XxMSA92y1UxVKJ7p7YPhS0mG667795" STYLE="fork"/>
              </node>
              <node TEXT="源码安装" ID="S6Rh3aHOcCQxTY5QghIzOeFakiK67796" STYLE="fork">
                <node TEXT="在configure的时候没有指定其他目录的情况下，nginx.conf目录在/usr/local/nginx下" ID="inkVnCVH0oiQRzk2uz8pkpNLUzR67797" STYLE="fork"/>
              </node>
              <node TEXT="添加新的server配置" ID="YbKVLV9acTXUPFz9b8dRvBIrTN767798" STYLE="fork">
                <node TEXT="https://github.com/JunManYuanLong/TcloudServer/blob/master/deploy/docs/%E5%BF%AB%E9%80%9F%E5%AE%89%E8%A3%85.md#%E4%BA%8C%E9%85%8D%E7%BD%AEnginx" ID="DKodz5qAihyIpiW5yNkwes2Efuz67799" STYLE="fork"/>
              </node>
              <node TEXT="重启Nginx" ID="mcXvctZFAdKEH3XUkMcQgObVcAu67800" STYLE="fork">
                <node TEXT="nginx -s reload" ID="bUtX6N9E0GYYd3wl0tnHFgUm1UX67801" STYLE="fork">
                  <node TEXT="如出现启动问题报错 nginx: [emerg] module &quot;/usr/lib64/nginx/modules/ngx_http_geoip_module.so&quot; version 1012002 instead of 1014000 in /usr/share/nginx/modules/mod-http-geoip.conf:1" ID="wm4bXftXqV7Lyg7vjcIrGfcc2DH67802" STYLE="fork"/>
                  <node TEXT="这个原因是因为以前nginx modules 和现在官方的modules 不匹配需要我们先将旧的modules 卸载安装新版官方的modules" ID="l0I6OdOR7sqBNTIVgi1FHRh7Pjq67803" STYLE="fork"/>
                  <node TEXT="yum remove nginx-mod*" ID="IeMeZEelArXuRR6gvyQAeZZyjWd67804" STYLE="fork"/>
                  <node TEXT="yum install nginx-module-*" ID="NsGM7vx8X2zvtUUNF0OamFBbKD567805" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="修改" ID="Ua0dsokoxaITnZ6jPh9PIBbZWni67806" STYLE="fork">
            <node TEXT="所有修改已集成在项目中" ID="6nl0wNVBYag4d0zmBOyVTBzSQd367807" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="" ID="ed1e6e4452dd45e0252a8afd1dcd7440" STYLE="fork"/>
      </node>
      <node TEXT="Windows部署（以win10为例）" ID="qpRZmChAtcOcgkWIsdIoKVR3PCX67808" STYLE="fork">
        <node TEXT="敬请期待..." ID="xypLy0dxyZPYhcbKek5lOQRPdCs67809" STYLE="fork"/>
      </node>
      <node TEXT="Mac上搭建（此方法可连接IOS设备）" ID="e38d6923b4dd3522ef187a5389756e97" STYLE="fork">
        <node TEXT="基本环境安装" ID="9b6fe053c3d7a3de3a8a7e1d09099e12" STYLE="fork">
          <node TEXT="去brew官网，复制命令安装" ID="3915c737dac577476b973d14f6cae1b8" STYLE="fork"/>
        </node>
        <node TEXT="配置Java环境" ID="995e63af955defba4341280a3976935c" STYLE="fork">
          <node TEXT="如果安装了brew后就可以直接用brew命令来安装一些软件了" ID="4017e23f197a9f9b49fe3eb81f377f3e" STYLE="fork">
            <node TEXT="brew install java" ID="e9ba40013ae98c278c43318429b5b630" STYLE="fork"/>
          </node>
          <node TEXT="检查环境" ID="d4bdecfeacb1cb90c496a8d6334028a8" STYLE="fork">
            <node TEXT="Java" ID="2444d7427928bb94cd18ebaa39009e6f" STYLE="fork"/>
            <node TEXT="javac" ID="7655dae0df87bb1843d13daef60ca17e" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="配置ADB" ID="ae171b1d7de4855814f0df25e6d6aec0" STYLE="fork">
          <node TEXT="去安卓官网下载SDK" ID="34696a742dadf1fa58a912e2df1771eb" STYLE="fork">
            <node TEXT="下载好了后再配置环境变量" ID="2073ae398fb197ee0feeffcda1f0b3e0" STYLE="fork">
              <node TEXT="vim .bash_profile" ID="50d35d9a70084ae6cc457fd7f5729cfc" STYLE="fork">
                <node TEXT="export PATH=${PATH}:/Users/lin/Library/Android/sdk/platform-tools;
export PATH=${PATH}:/Users/lin/Library/Android/sdk/tools;" ID="4c1926f925d29913af374f38f7e599d9" STYLE="fork">
                  <node TEXT="source .bash_profile" ID="d7c9d449c2a1ad32bc762f57ddac2b90" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="直接安装Android Studio" ID="ebe217752129c5fac82fe2d12fe749ba" STYLE="fork">
            <node TEXT="找到安装路径中的SDK路径" ID="9773a1573732d1ee7fe46a6d6a4dc73e" STYLE="fork">
              <node TEXT="vim .bash_profile" ID="14fbbab7832c8eb9c3e574be12b08899" STYLE="fork">
                <node TEXT="export PATH=${PATH}:/Users/lin/Library/Android/sdk/platform-tools;
export PATH=${PATH}:/Users/lin/Library/Android/sdk/tools;" ID="9b33a49945d43dd43d7988bc00bccd34" STYLE="fork">
                  <node TEXT="source .bash_profile" ID="c29cc552cec10f1a2fbbb32b8d9a29b7" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="检查ADB" ID="d6a41c8f2fd78a9ca1de91530bf46c62" STYLE="fork">
            <node TEXT="adb devices" ID="f484826dd56eea130ddac664058ce8c1" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="安装node" ID="72844045bc479f5f669c16b9cad672b7" STYLE="fork">
          <node TEXT="brew install node" ID="b94323d5f92b7e8d87039db94dfdfd55" STYLE="fork">
            <node TEXT="此方法会安装最新的node，但STF对于最新的node的兼容并不是太好所以建议安装8.19.0版本" ID="32ef8b730d9a648484794df4aae4eb2f" STYLE="fork">
              <node TEXT="如果已经安装好最新的node想降级，就用n来降级" ID="7e4c4de5a302ebcab660857b960f78b4" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="切换node版本" ID="f5bdb774d6ac3f8d9f2fc2bb13651d0d" STYLE="fork">
            <node TEXT="sudo npm install -g n" ID="0bddc755807b09eba4d31dab97ac945e" STYLE="fork">
              <node TEXT="安装最新稳定版本" ID="f27fdd24b8dedfa8231bc4808f9bf7aa" STYLE="fork">
                <node TEXT="sudo n stable" ID="0addc733258c25080508e24b702185f8" STYLE="fork"/>
              </node>
              <node TEXT="安装最新版本" ID="04c369a012b8980b8ea981d4611f8507" STYLE="fork">
                <node TEXT="sudo n latest" ID="030ba253797de68d0c349f9be7df0d68" STYLE="fork"/>
              </node>
              <node TEXT="安装指定版本" ID="be50aade8af4ad4cb5ca72cc032b817e" STYLE="fork">
                <node TEXT="sudu n 10.19.0" ID="3e406bf1d512248f199edf199025bb2d" STYLE="fork"/>
              </node>
              <node TEXT="删除某个版本" ID="5b80376e8a9cac27660b4f43e3e5f0e8" STYLE="fork">
                <node TEXT="n rm 10.13.0 " ID="5ecd50a686cd66c10cff027f20e288b9" STYLE="fork"/>
              </node>
              <node TEXT="使用n切换版本" ID="45da93733e65b0872c6218946aa05c67" STYLE="fork">
                <node TEXT="n" ID="54a25c9618a11ad50c320addf995ac83" STYLE="fork"/>
              </node>
              <node TEXT="以指定的版本来执行脚本" ID="f78eba11169e61c6270a81e871451eae" STYLE="fork">
                <node TEXT="n use 10.19.0 index.js" ID="71d3d08cbfcb729d72a67ee353248d9b" STYLE="fork"/>
              </node>
              <node TEXT="n帮助" ID="09ef570aae4649468b8f5f4dfd636eeb" STYLE="fork">
                <node TEXT="n help" ID="9dfaa2b037243603dff5b511660a3db7" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="检查node版本" ID="efe76a01a09720f5270f5e6762300053" STYLE="fork">
            <node TEXT="node -v" ID="19a8aacfc684df6545c0853833b98284" STYLE="fork"/>
            <node TEXT="npm -v" ID="d51b8117ef6e8294693f536524a3b806" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="安装rethinkdb" ID="3c5a259ae351615df46025ff19d25ac6" STYLE="fork">
          <node TEXT="用brew安装" ID="e3d5be42b4139ad315cedc25986e1a16" STYLE="fork">
            <node TEXT="brew install rethinkdb" ID="1f7ca57a6701ec7538d0510d106714f1" STYLE="fork"/>
          </node>
          <node TEXT="检查安装" ID="9174ce8b710d5da833e368899a8ea5e3" STYLE="fork">
            <node TEXT="rethinkdb -v" ID="32d422ba9cd7dc95d8780d5766fd7a4c" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="安装STF依赖工具" ID="5ff0773bef2c7b144300cb0c30223a63" STYLE="fork">
          <node TEXT="子主题 1" ID="1ed114de90131f8b3ef1b10a4f6dcc30" STYLE="fork">
            <node TEXT="brew install  usbmuxd" ID="f4bf43c0016b52e4dae8adcbf61daf61" STYLE="fork"/>
            <node TEXT="brew link usbmuxd" ID="1c668fdc695c7773ac3acd153e240cb5" STYLE="fork"/>
            <node TEXT="brew install --HEAD libimobiledevice" ID="1db1b561a7f90ae6a705bae7b5123005" STYLE="fork">
              <node TEXT="安装这两个工具的时候一定要用 --HEAD安装，否则不是最新的就获取不到设备信息，WDA会无限重启" ID="caf469360d037ee2df3131b56bf670f1" STYLE="fork"/>
            </node>
            <node TEXT="brew install --HEAD ideviceinstaller" ID="521e41ffa6145708be1b0406e64231b8" STYLE="fork">
              <node TEXT="安装这两个工具的时候一定要用 --HEAD安装，否则不是最新的就获取不到设备信息，WDA会无限重启" ID="983ea6c4850ac6e79319f4d14644a6a8" STYLE="fork"/>
            </node>
            <node TEXT="brew install carthage" ID="ce15828be2de7133b7e325ea34e577bf" STYLE="fork"/>
            <node TEXT="brew install socat" ID="608b87fb0b697a1dba4d981950ec5ad5" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="安装STF依赖" ID="73dba1dfedcef1ca00fddffdf6411fd4" STYLE="fork">
          <node TEXT="brew install graphicsmagick protobuf yasm pkg-config" ID="26fe4460cda5c1ce6fcffc2d4776345a" STYLE="fork"/>
          <node TEXT="检查所有依赖是否已正常安装（后面也可以cd到STF的bin目录下./stf doctor来检测）" ID="883417667c4c25e3a22efe2bfa8082eb" STYLE="fork">
            <node TEXT="graphicsmagick" ID="0de9457cfe83af1b952213aa67f63177" STYLE="fork">
              <node TEXT="gm" ID="1d91a2f227686ff171ab1075814ea083" STYLE="fork"/>
            </node>
            <node TEXT="protobuf" ID="2d822a1edba6bd5775cc176f89e6c7a8" STYLE="fork">
              <node TEXT="protoc --version" ID="a2c4ceabcafffb38de4cc7ad53a6e908" STYLE="fork"/>
            </node>
            <node TEXT="yasm" ID="a9a601729c8e451484d429528d484382" STYLE="fork">
              <node TEXT="yasm --version" ID="103072cad4dc5656a6bb1745b30d02cf" STYLE="fork"/>
            </node>
            <node TEXT="plg-config" ID="d90ca7563ef5b752ad7e599ff8165407" STYLE="fork">
              <node TEXT="pkg-config --version" ID="7a7e18dd0925d3e9f61118001e7b4d55" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="安装zmq" ID="b5ef530dc16c1548d2e488825c59be8a" STYLE="fork">
            <node TEXT="此工具不可用brew下载下来用，具体原因不太清楚，但是亲测是不行的，再执行./stf doctor时会包zmq的错" ID="a1ead692e3f2fa6d5c8ede6ce4cec1b9" STYLE="fork"/>
            <node TEXT="先去git上下载一个最新的压缩包" ID="4cf97f825620dab4a0f8893a6b37c41d" STYLE="fork">
              <node TEXT="https://github.com/zeromq/libzmq/releases" ID="6ff1ad88762806ee841936f8de852cf9" STYLE="fork">
                <node TEXT="解压，并cd到那个目录后，./configure" ID="0c371e52ee4997add4743ee5d7a95bf0" STYLE="fork">
                  <node TEXT="make" ID="b093d981e7858c882427534f7947b3f3" STYLE="fork">
                    <node TEXT="make install" ID="dc8948f353244fb2c7fdbd1a90584318" STYLE="fork"/>
                  </node>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="配置WebDriverAgent" ID="a18e3f20dde2cd21088add0dd5cdc364" STYLE="fork">
          <node TEXT="拉取WDA代码" ID="7a510f0685cdd482abca830b38419be0" STYLE="fork">
            <node TEXT="git clone https://github.com/mrx1203/stf.git" ID="60c862f626f2ac0d42677cb6ab986c98" STYLE="fork"/>
          </node>
          <node TEXT="编译WDA" ID="0884d1b3b45e119190a0f7d73cc971be" STYLE="fork">
            <node TEXT="cd到WDA根目录" ID="1705fb8fd682fe2588ecdc57545888b8" STYLE="fork">
              <node TEXT="./Scripts/bootstrap.sh" ID="49294ab39d018187959a3bb161ccb6a0" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="用XCode打开WDA目录中的WebDriverAgent.xcodeproj" ID="8d19b201c77aaa8abd6aee23230077dd" STYLE="fork">
            <node TEXT="WebDriverAgentLib" ID="b3263c39d0797db8d8df93118c7e6ac3" STYLE="fork">
              <node TEXT="General" ID="3dfe59055264eeabf8d0a8c5492a91a8" STYLE="fork">
                <node TEXT="在Signin中的Team中选择自己的账号" ID="884be8eaf5e5d7dd4d3a05cc7d50165d" STYLE="fork"/>
              </node>
              <node TEXT="Build Settings" ID="ad5266d6dec6027cfb9ac92f78009ba3" STYLE="fork">
                <node TEXT="将Build Bundle改成自己的" ID="434958a73b26c4ba4c4fa221e5e5db64" STYLE="fork">
                  <node TEXT="不知道自己的Build Bundle可以去重新创建一个项目，去同样的地方找到这个Build Bundle就可以了" ID="c2cd6c9771a29f969a4199bb2233157e" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="WebDriverAgentRunner" ID="fed2faead2f607c9e32462cdbc67797b" STYLE="fork">
              <node TEXT="General" ID="213d4b69fd27e2314fb74224031b82a4" STYLE="fork">
                <node TEXT="在Signin中的Team中选择自己的账号" ID="9535d2a7cc78201724c050de661df6a5" STYLE="fork"/>
              </node>
              <node TEXT="Build Settings" ID="5537c536ebd9f2812fffc3557c73bc4e" STYLE="fork">
                <node TEXT="将Build Bundle改成自己的" ID="55d0b98cfd7836794f8eb39b62a6364e" STYLE="fork">
                  <node TEXT="不知道自己的Build Bundle可以去重新创建一个项目，去同样的地方找到这个Build Bundle就可以了" ID="7aa91bfc31ed11d37b3ae003c1c5600e" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="Destinstion" ID="9952aa74b63a94e8458f8e54e8e03385" STYLE="fork">
            <node TEXT="选择自己的手机" ID="cfd07c9519eb114410eb0b560348ad4d" STYLE="fork"/>
          </node>
          <node TEXT="在XCode里面选择" ID="d62ac4d6b49572ec900af4ce70a69449" STYLE="fork">
            <node TEXT="product" ID="f00e14466487cfdab21781ebb06191ec" STYLE="fork">
              <node TEXT="schema" ID="02b781d49e45bce462dd8e4d6f11f5e2" STYLE="fork">
                <node TEXT="WebDriverAgentRunner" ID="454a6fa2e4cc1b1857eb87a360e35ab5" STYLE="fork">
                  <node TEXT="test" ID="8ae851163b8368fb96818c09874ce26c" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="STF重构" ID="e99010fc9dcf6c3d0364ba9df74cd4d0" STYLE="fork">
          <node TEXT="cd到STF根目录" ID="f7e02205446dd8887db197fc15635ec8" STYLE="fork">
            <node TEXT="npm install" ID="bcc346ff4108441b62847ed3ffce78fd" STYLE="fork">
              <node TEXT="sudo npm link" ID="39e87ca762c124a908c9cd5669859e63" STYLE="fork">
                <node TEXT="每一次STF文件夹中的文件有更改的时候，都需要重新npm install和sudo npm link一次" ID="3586d6e17789bc490f3ace3df04c2df6" STYLE="fork"/>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="启动STF" ID="374ca7fcc9a14a93a0afcdb919485498" STYLE="fork">
          <node TEXT="作为主服务器" ID="dfa64ac3ce757fbed9cf99b35b8a5414" STYLE="fork">
            <node TEXT="./stf local --public-ip 192.168.13.180 --wda-path /Users/lin/WebDriverAgent/ --wda-port 8100 --allow-remote" ID="cfb944792582b78d78a011cc58ac4773" STYLE="fork"/>
          </node>
          <node TEXT="作为从服务器" ID="ce526a19ceb3f39535fc675aa83f9d43" STYLE="fork">
            <node TEXT="./stf ios-provider --name &quot;lin&quot; --connect-sub tcp://192.168.9.121:7114 \
--connect-push tcp://192.168.9.121:7116 --storage-url http://192.168.9.121:7100 \
--public-ip 192.168.13.180 —heartbeat-interval 20000 \
--wda-path /Users/lin/WebDriverAgent --wda-port 8100" ID="826ad3a8dee83199aaee7ac6cce6c24d" STYLE="fork"/>
          </node>
        </node>
      </node>
    </node>
  </node>
</map>