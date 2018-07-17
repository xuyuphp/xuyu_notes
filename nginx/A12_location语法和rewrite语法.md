## location语法和rewrite语法 ##
----------
## location ##
## (1)符号区别 ##
 - `~` >> 区分大小写
 - `~*` >> 不区分大小写
 - `!` >> 取反
 - `^~` >>  /images/ 有/images/就走这里 优先匹配

 ----------

##  (2)匹配优先级 ##
- (1) `location =/ {}` >> 精确匹配
- (2) `locatin ^~/images/ {}` >> 匹配常规后不做正则匹配
- (3) `locatin ~*\.(gif|jpg|jpeg)$` >> 正则匹配
- (4) `location /document/ {}` >> 匹配常规，有正则优先匹配正则
- (5) `location / {}` >> 所有location都不能匹配后匹配这个

----------
## rewrite ##
## 语法 ##
 - `rewrite regex replacement [flag];` >> (server locatin ,if )
 ----------

## (1)符号区别 ##
- `\` >> 转义字符
- `^` >> 匹配字符串的开始位置
- `$` >> 匹配字符串的结束位置
- `*` >> 匹配前面的字符0次或者多次
- `+` >> 匹配前面的字符1次或者多次
- `?` >> 匹配前面的字符0次或者1次
- `.` >> 匹配\n之外的任何字符，要包含\n,写法为[.\n]
- `(pattern)` >> 匹配内容pattern

 ----------

## (2)flag参数 ##
- `last` >> 本条规则匹配玩之后，继续向下匹配新的location,使用alias指令时必须用last
- `break` >> 本条规则匹配玩后终止，不匹配其他location,使用proxy_pass时要使用break
- `redirect` >> 返回302临时重定向,浏览器地址栏会显示跳转后的url
- `permanent` >> 返回301 永久重定向,浏览器地址栏会显示跳转后的url,nginx关闭后也能访问到重定向结果
 ----------

## (3)例子 ##
- `rewrite ^(.*)$ /pages/maintain.html break;` >>  所有的页面都重定向到这里
- `rewrite ^/product\.html/{\d+}$ /product\.php\?a\={$1} break;`


