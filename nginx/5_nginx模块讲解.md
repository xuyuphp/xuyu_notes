## nginx模块讲解 ##
----------
## 用到命令 ##
 - `nginx -tc /etc/nginx/nginx.conf` >>检验配置文件是否出错

 ----------
## --with-http_stub_status_module ##
 - 作用： nginx客户端状态（server || location级别）
 - 代码配置:
 - `location /stub_status {`
 - `stub_status;`
 - `}`
 - 浏览器访问http://45.77.22.42/stub_status得到
 - Active connections: 2 >> nginx活跃连接数
 - server accepts handled requests
 - 84 84 82  >> 总握手次数、nginx处理的连接数、总的请求数
 - Reading: 0 Writing: 1 Waiting: 1 >> nginx正在读的个数、nginx正在写的个数、nginx等待数
  
----------
## --with-http_random_index_module ##
 - 作用： 目录中选择一个随机主页（location级别）
 - 代码配置:
 - `location / {`
 -  `root /html;`
 -	`random_index on;` >> 开启random_index随机主页，会出现/html下面的随机页面
 - `}`
 
----------
## --with-http_sub_module ##
 - 作用：nginx_http返回的内容替换（http || server || location 级别）
 - 代码配置：
 - `location / {`
 -  `root /html;`
 -	`index index.html;`
 -	`sub_filter '1' '2';` >> 把返回的html中的1替换为2
 -	`sub_filter_once on;` >> on为只替换第一个
 - `}`
