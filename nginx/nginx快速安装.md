## nginx快速安装 ##
----------
## 官网 ##
 - 下载gitlab安装包地址：http://nginx.org/en/download.html >> 点击下方的 "stable version"按钮 >>
   复制"Pre-Built Packages for Mainline version"框中代码"OS/OSRELEASE"修改为"centos/7"
 ----------
## 安装前检测环境 ##
 - `~]# iptables -L` >> 查看iptables规则
 - `~]# iptables -t nat -L` >> 查看nat表的iptables规则
 - `~]# getenforce` >> 查看查看selinux
 - `~]# iptables -F` >> 关闭iptables规则
 - `~]# iptables -t nat -F` >> 关闭nat表的iptables规则
 - `~]# setenforce 0` >> 关闭selinux
 
----------
## 2.安装nginx ##
 - `vim /etc/yum.repos.d/nginx.repo` ; 创建nginx.repo写入下列代码
- `[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1` >> 复制的时候注意换行,请查看源代码换行
 - `yum list | grep nginx` ; 查看你nginx安装包
 - `yum -y install nginx` ; 安装nginx
 - `nginx` ; 启动nginx
 - `ps -ef | grep nginx` ; 查看nginx进程

----------
## 其他命令 ##
   - `nginx -v` >> 查看nginx版本
   - `nginx -V` >> 查看nginx的编译参数
   - `nginx -s reload` ; 重启nginx
