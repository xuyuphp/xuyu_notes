## nginx跨域配置和防盗链 ##
----------
## nginx跨域配置 ##
 - (1)场景 >> html页面ajax请求到其他域下
 - (2)语法： `add_header name value [always];` >> 允许跨站访问(http,server,location)
 - (3)代码示例：
 - `location ~ .*\.(htm|html)$ {`
 -	&nbsp;&nbsp;&nbsp;&nbsp;`add_header Access-Control-Allow-Origin http://www.other.com;` >>    允许访问的域名，`http://www.other.com`改为*为所有的站点都可以来访问，不推荐使用
 -	&nbsp;&nbsp;&nbsp;&nbsp;`add_header Access-Control-Allow-Methods GET,POST,PUT,DELETE,OPTIONS;` >> 允许访问的方式
 -	&nbsp;&nbsp;&nbsp;&nbsp;`root  /usr/share/nginx/html/`
 -  `}`

 ----------
## http_referers防盗链(server,location)##
 - `valid_referers none blocked 45.77.22.42;`解析：
 - (1)`none` >> 表示没有referer信息的过来
 - (2)`blocked` >> 表示不是带`http://`的也是允许的
 - (3)`45.77.22.42` >> 只允许`116.62.103.228`访问 >> 其他书写方式`server_names *.baidu.com;`
 - 代码配置：
 - `location ~ .*\.(js|gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG|css|bmp)$ {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`valid_referers none blocked 45.77.22.42;` 
 - &nbsp;&nbsp;&nbsp;&nbsp;`if ($invalid_referer) {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`return 403;` >>也可以显示一张防盗链图片 rewrite ^/ http://www.baodu.com;
 - &nbsp;&nbsp;&nbsp;&nbsp;`}`
 - `}`
 - 测试：
 - (1)`curl -e "http://www.baidu.com" -I http://45.77.22.42/xuyu.jpg` >> 返回`HTTP/1.1 403 Forbidden`
 - (2)`curl -e "http://45.77.22.42" -I http://45.77.22.42/xuyu.jpg` >> 返回`HTTP/1.1 200 OK`


