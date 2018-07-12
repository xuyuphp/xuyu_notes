## nginx负载均衡##
----------

## 基础知识##
 - 四层负载均衡：在传输层tcp/ip协议包转发，性能快
 - 七层负载均衡：在应用层，完成http头信息的改写等，nginx属于七层负载均衡
 - `iptables -I INPUT -p tcp --dport 8002 -j DROP` >> 关闭8002端口

 ----------

## 参数解析##
- `down` >> 当前server暂时不参加负载均衡
- `backup` >> 当有节点挂掉时，参加负载均衡，备份节点
- `max_fails` >> 允许请求失败的次数
- `fail_timeout` >> max_failsf次数用完后，服务暂停的时间
- `max_conns` >> 限制最大的链接数，因为服务器性能不同，所以请求数的负载也不同
 ----------


## 代码配置##
- (1) `upstream imooc {`  >> (写在http层)
- &nbsp;&nbsp;&nbsp;&nbsp;`ip_hash;` >> 根据用户地址访问同一个服务器
- &nbsp;&nbsp;&nbsp;&nbsp;`hash $request_uri;` >> 根据url判断（重点）
- &nbsp;&nbsp;&nbsp;&nbsp;`server 116.62.103.228:8001 weight=5;` >> 权重为5，有7个请求分配5个给此服务器
- &nbsp;&nbsp;&nbsp;&nbsp;`server 116.62.103.228:8002 max_fails=1 fail_timeout =10s;`
- &nbsp;&nbsp;&nbsp;&nbsp;`server 116.62.103.228:8003 backup;` >> backup表示该节点为备份节点
- `}`
- (2)`location / {`
- &nbsp;&nbsp;&nbsp;&nbsp;`proxy_pass http://imooc;`
- &nbsp;&nbsp;&nbsp;&nbsp;`include proxy_params;` >> 此文件为在上节里讲到过
-`}`

