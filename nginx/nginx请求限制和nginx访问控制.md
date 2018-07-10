## nginx请求限制和nginx访问控制 ##
----------
## nginx请求限制 ##
 - <font color="#dd0000">基础知识：</font><br />
 - req_zone_module >> 请求频率模块，conn_zone__module >> 链接频率模块
 - `$binary_remote_addr`数据量比`$remote_addr`小，都是客户端IP地址
 - `ab -n 50 -c 20 http://www.baidu.com` >> ab压力测试 >> 请求50，并发20，请求地址(ab安装见后面)
 - <font color="#dd0000">代码配置：</font><br />
 - `http {`
 -  &nbsp;&nbsp;&nbsp;&nbsp;`limit_req_zone $binary_remote_addr zone=req_zone:1m rate=1r/s;` >> 根据客户端地址$binary_remote_addr,给1m空间别称为req_zone,对于同一个客户端ip在1s内请求一次(http层)
 -	&nbsp;&nbsp;&nbsp;&nbsp;`limit_conn_zone $binary_remote_addr zone=coon_zone:1m;`   >> (http)
 -	&nbsp;&nbsp;&nbsp;&nbsp;`server {`
 -		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`location / {`
 -			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`limit_req zone=req_zone burst=3 nodelay;` >> 超过1个后三个到下一秒执行，nodelay其余的阻塞，burst=3 nodelay 为可选参数
 -			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`limit_conn coon_zone 1;` >> 服务端同一时刻只允许一个ip链接过来
 -		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`}`	
 -	&nbsp;&nbsp;&nbsp;&nbsp;`}`
 - `}`

 ----------
## nginx访问控制 ##
## 1.http_access_module >> 基于ip的访问控制 ##
 - <font color="#dd0000">语法：</font><br />
 - `allow address|CIDR` >> 允许的ip|网段 (http,server,location) >> 192.168.0.0/8 网关/子网掩码 255.0.0.0->8 255.255.0.0->16 255.255.255.0->24
 - `deny address|CIDR` >> 不允许的ip|网段 (http,server,location)
 - <font color="#dd0000">代码示例：</font><br />
 - `location ~ ^/image/.*\.(php|php5|sh|pl|py)$ {` >> #html/image 里的脚本禁止访问,放在php配置前面,多个目录/(image|static)/
 - &nbsp;&nbsp;&nbsp;&nbsp;`allow 192.168.0.138;` >> 允许192.168.0.138访问 192.168.0.0/8 网关/子网掩码 255.0.0.0->8 255.255.0.0->16 255.255.255.0->24以此类推
 - &nbsp;&nbsp;&nbsp;&nbsp;`deny all;` >> 除了上面允许其他都禁止
 - `}`
 - <font color="#dd0000">流程图：</font><br />
 - `ip1 >>prox_ip2>>nginx_ip3` >> nginx获取的`$remote_addr`是ip2，`x_forwarded_for`获取的是ip1,ip2
 - <font color="#dd0000">局限性：</font><br />
 - (1) 采用`x_forwarded_for`头信息访问，(可能被修改过)
 - (2) 结合geo模块
 - (3) 通过http自定义变量传递$remote_addr >> 后续讲到

## 2.http_auth_basic_module >> 基于用户的信任登录(http,server,location) ##
 - <font color="#dd0000">语法：</font><br />
 - `auth_basic string|off;` >> 客户端访问显示string或者关闭
 - `auth_basic_user_file file_path;` >> file_path为存储用户认证信息的文件位置
 - <font color="#dd0000">(1)httpd-tools生成密码存储文件：</font><br />
 - yum -y install httpd-tools >>  安装密码加密工具httpd-tools
 - `[root@tokyo nginx]# cd /etc/nginx/`
 - `[root@tokyo nginx]# htpasswd -c ./auth_conf xuyu` >>创建xuyu用户点击回车，输入2次密码返回如下信息
 - `New password: Re-type new password: Adding password for user xuyu`
 - `[root@tokyo nginx]# more auth_conf` >>查看生成的auth
 - `[root@tokyo nginx]# pwd` >> 返回路劲<font color="#660066">/etc/nginx（file_path）</font><br /> 
 - <font color="#dd0000">(2)代码配置：</font><br />
 - `location / {`
 - 	&nbsp;&nbsp;&nbsp;&nbsp;`auth_basic "Auth_test!input you passward!";`
 - 	&nbsp;&nbsp;&nbsp;&nbsp;`auth_basic_user_file /etc/nginx/auth_conf;`
 - `}`
 - `[root@tokyo nginx]# nginx -tc nginx.conf` >> 检查
 - `[root@tokyo nginx]# nginx -s reload` >> 重启
 - <font color="#dd0000">(2)测试：</font><br />
 - 访问http://45.77.22.42/需要输入用户名和密码配置成功
 - <font color="#dd0000">局限性：</font><br />
 - 1.用户依赖文件方式
 - 2.机械管理，效率低下
 - <font color="#dd0000">解决方式：</font><br />
 - nginx+lua方式 >> 后续讲到
