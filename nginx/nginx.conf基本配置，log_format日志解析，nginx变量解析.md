## nginx.conf基本配置，log_format日志解析，nginx变量解析 ##
----------
## 基本配置 ##
 - `user  nginx;` >> 设置nginx的系统使用用户
 - `worker_processes  1;` >> 工作的进程数，设置为cpu核数,查找cpu核数命令：`grep processor /proc/cpuinfo |wc -l`
 - `error_log  /var/log/nginx/error.log warn;` >> 错误日志"warn"级别
 - `pid        /var/run/nginx.pid;` >> nginx启动服务时候的pid
 - `events {`
 - &nbsp;&nbsp;&nbsp;&nbsp;`worker_connections  1024;` >> 每个进程的最大连接数
 - &nbsp;&nbsp;&nbsp;&nbsp;`use epoll;` >> epoll工作模式
 -  `}`
 - `http {`
 -  `include       /etc/nginx/mime.types;` 
 -  `default_type  application/octet-stream;`
 -  `server_tokens off;` >> nginx隐藏版本号
 -  `sendfile        on;` >> 页面静化支持buffer开启
 -  `keepalive_timeout  60;` >> 服务器与客户端连接请求超过60s断开连接
 -  `access_log  /var/log/nginx/access.log  main;` >> 以log_format main的格式写入access_log
 -  `server {`
 -  &nbsp;&nbsp;&nbsp;&nbsp;`listen       80;` >> 监听端口
 -  &nbsp;&nbsp;&nbsp;&nbsp;`server_name  locahost;` >> 每个server服务最多设置三个散表,先搜索准确的，再搜索以*开头的，最后搜索以*结尾的
 -  &nbsp;&nbsp;&nbsp;&nbsp;`charset utf-8;` >> nginx编码设置
 - &nbsp;&nbsp;&nbsp;&nbsp;`location / {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`root         html;` >> index.html所在的目录
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`index  index.html index.htm;`
 - `}`
 - `error_page  500 502 503 504  /50x.html;`
 - `location = /50x.html {`
 - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`root   html/error/;` >> 50x.html存放在此路劲下
 - &nbsp;&nbsp;&nbsp;&nbsp`}`
 - &nbsp;&nbsp;&nbsp;&nbsp`}`
 - `include /etc/nginx/conf.d/*.conf;` >> 加载其余配置文件目录
`}`

 ----------
## log_format变量解析 ##
 - `$remote_addr` >> 客户端的地址
 - `$remote_user`  >> 客户端请求nginx默认的用户名，没开启remoter认证模块就没有
 - `$time_local` >> nginx时间
 - `$request` >> http请求行
 - `$status` >> response返回状态
 - `$body_bytes_sent` >> 服务端响应body信息的大小
 - `$http_referer` >> 上级页面的url地址，防盗链用到
 - `$http_user_agent` >> 客户端用什么访问的
 - `$http_x_forwarded_for` >> 后续讲到
 
----------
## nginx变量解析 ##
 - `arg_id`  >> request请求参数id在nginx里获取,格式"arg_ + request"里的请求参数
 - `http_id` >> request_heard里的参数，格式"http_ + request_heard"里的参数
 - `sent_http_id` >> response_heard里的参数，格式"sent_http_ + response_heard"里的参数

 
----------
## http请求基本知识 ##
 - request >> 包括请求行，请求头，请求数据
 - response >> 包括状态行，消息报文，相应正文
