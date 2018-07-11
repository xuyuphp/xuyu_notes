## nginx作为静态资源服务器的基本配置 ##
----------
## 前景提要和基本知识 ##
 - `sendfile on|off;` >> 打开buffer直传功能(http,server,location)
 - `tcp_nodelay on|off;` >>提高网路传输的实时性(http,server,location) >> 前提条件：keepalive连接下
 - `tcp_nopush on|off;` >> 提高网络包的传输效率 (http,server,location) >> 前提条件：sendfile开启的情况，常用于实时性不高的下载等
 - 逻辑假设：10个包裹一天发一个，需要10天，nopush是把10个包裹打包一天发；

 ----------
## gzip on|off; >> gzip压缩(http,server,location) ##
## (1)代码示例 ##
 - `gzip on|off;` >> gzip压缩(http,server,location)
 - `location ~ .*\.(js|gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG|css|bmp)$ {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`root  /usr/share/nginx/;`
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip  on;` #开启gzip压缩功能
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_min_length 1k;` #允许压缩页面的最小字节
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_buffers 4 32k;` #压缩缓冲区大小
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_http_version 1.1;` #压缩版本
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_comp_level 2;` #压缩等级1-9之间
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_types text/css text/xml application/javascript image/jpeg;` #压缩文件类型
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_vary on;` #该选项可以让前端缓存服务器缓存经过gzip压缩页面
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_disable "MSIE[1-6]\.";` #禁用IE浏览器1-6
 - `}`
 ## (2)验证方法 ##
 -  强制刷新谷歌查看response_headers 下Content-Encoding: gzip

 ----------
## http_gzip_static_module >> 预读gzip功能 >> 减少gzip的压缩时间 ##
 - (1)`gzip /usr/share/nginx/download/xuyu.jpg` >> 手动压缩xuyu.jpg
 - (2)代码配置
 - &nbsp;&nbsp;&nbsp;&nbsp;`location ~ ^/download {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`gzip_static on;` >>开启gzip预读
 - &nbsp;&nbsp;&nbsp;&nbsp;`tcp_nopush on;` >> 提高网络传输效率
 - &nbsp;&nbsp;&nbsp;&nbsp;`root /usr/share/nginx/download;`
 - `}`
 - 优点: 不需要吃cpu资源
 - 劣势：吃硬盘资源

----------
## 浏览器缓存 expires ##
 - (1)代码配置
 - `location ~ .*\.(htm|html)$ {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`expires 1d;` # 缓存一天
 - `}`
 - (2)校验方法：配置后出现f5,代码返回为304代表设置成功，response_header 里Cache-Control: max-age=86400，86400s正好是一天
  





