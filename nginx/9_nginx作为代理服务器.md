## nginx作为代理服务器 ##
----------

## 基础知识 ##
 -  语法：`proxy_pass URL;` >> (location)
 -  URL:格式`http://localhost:8000/url`,也支持https的协议本机ip地址写为127.0.0.1；

 ----------

## 反向代理 (代理的对象是服务器) ##
 - 代码示例：
 - `server {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`listen 80;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`location / {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`proxy_pass http://127.0.0.1:8080;` >> 转到本机的8080端口
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`include proxy_params;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`}`
 - `}`
 - 在`nginx.conf`同级目录下新建`vim proxy_params`文件内容如：
 - `proxy_redirect default;` >> 跳转重定向(http,server,location)
 - `proxy_set_header Host $http_host;` >> 传递头信息参数host
 - `proxy_set_header X-Real-IP $remote_addr;` >> 传递用户ip
 - `proxy_connect_timeout 30;`
 - `proxy_send_timeout 60;`
 - `proxy_read_timeout 60;`
 - `proxy_buffer_size 32k;`
 - `proxy_buffering on;` >> 打开吃内存需配置下列代码:
 - `proxy_buffers 4 128k;`
 - `proxy_busy_buffers_size 256k;`
 - `proxy_max_temp_file_size 256k;`

 ----------
## 正向代理(代理的视客户端）##
 - (1)被代理的服务器b配置
 - `location / {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`if ( $http_x_forwarded_for !~* "^116\.62\.103\.28" ) {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`return 403;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`}`
 - `}`
 - (2)代理116.62.103.28的服务器a配置
 - `server {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`listen 80;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`resolver 8.8.8.8;` >> dns解析
 - &nbsp;&nbsp;&nbsp;&nbsp;`localhost / {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`proxy_pass http://$http_host$request_uri;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`}`
 - `}`
 - (3)验证：
 - 浏览器设置a代理服务器地址进行访问，能访问就成功
 
