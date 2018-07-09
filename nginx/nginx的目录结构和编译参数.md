## nginx的目录结构和编译参数 ##
----------
## 常用命令 ##
 - `rpm -ql nginx` >> 查看nginx所有安装文件目录
 
 ----------
## 目录结构 ##
 - `/etc/logrotate.d/nginx` >> 配置文件 >>用于logrotate服务切割日志
 - `/etc/nginx/nginx.conf` >> 启动前加载的配置文件
 - `/etc/nginx/conf.d/default.conf` >> 启动后加载的配置文件
 - `/etc/nginx/fastcgi_params ` >> fastcgi配置文件
 - `/etc/nginx/scgi_params ` >> scgi配置文件
 - `/etc/nginx/uwsgi_params ` >> uwsgi配置文件
 - `/etc/nginx/mime.types` >> 设置http协议contenttype与扩展名的对应关系，nginx识别不了扩展名时候在这添加
 - `/usr/sbin/nginx` >> nginx服务的启动管理
 - `/usr/sbin/nginx-debug` >> nginx-debug调试服务的启动管理
 - `/usr/cache/nginx` >> nginx 静态文件cache缓存目录
 - `/usr/log/nginx` >> nginx的日志目录
 - 用于配置系统守护进程管理器的管理方式
   `/usr/lib/systemd/system/nginx-debug.service`
   `/usr/lib/systemd/system/nginx.service`
   `/etc/sysconfig/nginx`
   `/etc/sysconfig/nginx-debug`
 - nginx安装新模块位置
   `/usr/lib64/nginx/modules`
   `/etc/nginx/modules`
 
----------
## 编译参数 ##
 - `--prefix=/etc/nginx`  >> nginx主目录
 - `--sbin-path=/usr/sbin/nginx` >> nginx执行命令目录
 - `--modules-path=/usr/lib64/nginx/modules` >> nginx执行模块目录
 - `--conf-path=/etc/nginx/nginx.conf` >> nginx配置文件目录
 - `--error-log-path=/var/log/nginx/error.log` >> nginx错误日志目录
 - `--http-log-path=/var/log/nginx/access.log` >> nginx访问日志目录
 - `--pid-path=/var/run/nginx.pid` >> nginx 启动pid目录
 - `--lock-path=/var/run/nginx.lock` >> nginx 锁目录
 - `--user=nginx` >> nginx用户
 - `--group=nginx` >> nginx用户组
 - 执行对应模块时nginx所保留的临时性文件
 `--http-client-body-temp-path=/var/cache/nginx/client_temp`
 `--http-proxy-temp-path=/var/cache/nginx/proxy_temp` 
 `--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp` 
 `--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp` 
 `--http-scgi-temp-path=/var/cache/nginx/scgi_temp`
 - 其他模块
 `--with-compat` 
`--with-file-aio` 
`--with-threads` 
`--with-http_addition_module` 
`--with-http_auth_request_module` 
`--with-http_dav_module` 
`--with-http_flv_module` 
`--with-http_gunzip_module` 
`--with-http_gzip_static_module` 
`--with-http_mp4_module` 
`--with-http_random_index_module` 
`--with-http_realip_module` 
`--with-http_secure_link_module` 
`--with-http_slice_module` 
`--with-http_ssl_module` 
`--with-http_stub_status_module` 
`--with-http_sub_module` 
`--with-http_v2_module` 
`--with-mail` 
`--with-mail_ssl_module` 
`--with-stream` 
`--with-stream_realip_module` 
`--with-stream_ssl_module` 
`--with-stream_ssl_preread_module`

----------

 - 不常用参数
`--with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC'` >> 设置编译额外的参数被添加到CFLAGS(不常用)
`--with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'` >> 设置附加参数，链接系统库(不常用)
  
