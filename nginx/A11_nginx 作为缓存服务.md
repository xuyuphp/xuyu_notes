## nginx 作为缓存服务##
----------

## 基础知识##
 - 服务端缓存redis
 - 代理缓存nginx

 ----------


## 代码配置##
- `proxy_cache_path /opt/app/cache levels=1:2 keys_zone=imooc_cache:10m max_size=10g inactive=60m use_temp_path=off;` >>路劲|目录级别|给10m的空间别名为imooc_cache|目录最大为10g|超过10g且60m内没被访问的缓存被清理掉|关闭临时目录(http)
- `if ( $request_uri ~ ^/(url3|login)) {`
- &nbsp;&nbsp;&nbsp;&nbsp;`set $cookie_nocache 1;` >> url3,login不缓存
- `}`
- `location / {`
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_cache imooc_cache;`
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_pass http://imooc;`
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_cache_valid 200 304 12h;`
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_cache_valid any 10m;` >> 除了200和304的十分钟过期
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_cache_key $host$uri$is_args$args;` >> 缓存维度url
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_no_cache $cookie_nocache;` >> 不缓存页面
-	&nbsp;&nbsp;&nbsp;&nbsp;`add_header Nginx-Cache "$upstream_cache_status";` >> 添加客户端头信息是否缓存
-	&nbsp;&nbsp;&nbsp;&nbsp;`proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;` 如果当前服务器有超时，不正常头，错误，503,504等访问下一台服务器
- }

