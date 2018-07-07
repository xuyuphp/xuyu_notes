## gitlab搭建 ##
----------
## 基本认识和所需的linux命令 ##
 - ee是企业版，ce是社区版本(协议宽松些)，相当吃系统资源，建议部署在单独服务器,和nginx会发生端口冲突
 - 下载gitlab安装包地址：https://packages.gitlab.com/gitlab/
 - `[root@tokyo gitlab]# cat /etc/redhat-release` 查看CentOS 版本
 
----------
## 1.下载对应的安装包 ##
 - https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/7/gitlab-ce-11.0.2-ce.0.el7.x86_64.rpm
 - tips:查看linux系统版本下载对应的gitlab安装包，这里为CentOS7对应的安装包

----------
## 2.安装gitlab ##
 - `[root@tokyo gitlab]# mkdir /application/gitlab/` ; 创建存放目录
 - `[root@tokyo gitlab]# cd /application/gitlab/` ; 进入存放目录
 - `[root@tokyo gitlab]# rz` ; 上传已经下载的gitlab安装包
 - `[root@tokyo gitlab]# rpm -ivh gitlab-ce-11.0.2-ce.0.el7.x86_64.rpm` ; 安装gitlab
 - tips:`error: Failed dependencies:policycoreutils-python is needed by gitlab-ce-11.0.2-ce.0.el7.x86_64` 出现上述错误应该安装`yum install policycoreutils-python` 依赖
 
----------
## gitlab配置 ##
 1. 在CentOS 7 上，在防火墙中打开HTTP和SSH访问
   `sudo yum install -y curl policycoreutils-python openssh-server`
   `sudo systemctl enable sshd`
   `sudo systemctl start sshd`
   `sudo firewall-cmd --permanent --add-service=http`
   `sudo systemctl reload firewalld` 
 2. 安装Postfix以发送通知电子邮件
   `sudo yum install postfix`
   `sudo systemctl enable postfix`
   `sudo systemctl start postfix`
 3. 安装GitLab包ce依赖扩展库
   `curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash`
 4. 配置自己的服务器域名EXTERNAL_URL
   `sudo EXTERNAL_URL="http://45.77.22.42" yum install -y gitlab-ce`
 5. 初始化启动gitlab
   `gitlab-ctl reconfigure` >> 初始化gitlab
   `gitlab-ctl start` >> 启动gitlab

----------
## 浏览器访问gitlab ##
 1. 浏览器访问http://45.77.22.42 >> 如果访问不,需要关闭防火墙  `service firewalld stop`
 2. 设置密码 qing928130564 >> 默认账号为root
 

----------
## 其他gitlab操作 ##
  `gitlab-ctl stop` >> 停止gitlab
  `gitlab-ctl restart` >> 重启gitlab
  `vim /etc/gitlab/gitlab.rb` >> 配置文件位置