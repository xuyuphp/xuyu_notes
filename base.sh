#!/bin/bash
#<基础脚本>
# (1)set ff=unix (2) chmod 770 (3) ./bsse.sh 
echo "set nu" >> ~/.vimrc #vim设置编号
yum -y install lrzsz pcre-devel pcre openssl-devel gcc gcc-c++ tree make automake wget http-tools #nginx安装依赖包
yum -y remove libnuma.so.1 #mysql 安装依赖包
yum -y install pcre pcre-devel autoconf numactl.x86_64 
#php安装依赖包
yum -y install zlib-devel libxml2-devel libjpeg-devel libjpeg-turbo-devel libiconv-devel freetype-devel libpng-devel gd-devel licurl-devel libxslt-devel libmcrypt-devel mhash mcrypt curl-devel 