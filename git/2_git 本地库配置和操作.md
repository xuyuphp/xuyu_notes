﻿## git 本地库配置和操作 ##
----------
## 1.初始化本地数据库 ##
 - `$ git init` >>初始化本地数据库，创建.git/目录，里面存放的是本地数据库相关的文件，ls -la 可以查看


----------
## 2.设置签名 ##
 - `$ git config user.name xuyu` ; `$ git config user.email xuyu@php.com` >>设置项目级别用户名和邮箱
 - `$ cat /d/git_localtion/.git/config`; >>可以查看到[user]下设置用户名和密码
 - `$ git config --global user.name xuyu_golbal` ; `$ git config --global user.email xuyu@php_global.com` >>设置系统级别用户名和邮箱（推荐）
 - `$ cat ~/.gitconfig`; >>查看家目录下的系统用户
 - tips:项目用户优先级大于系统用户级别，一般设置系统用户级别

----------
## 3.工作区提交到暂存区 ##
 - `$ git add test.txt` ; 

----------
## 4.提交到本地仓库 ##
 - `$ git -m "first commit" commit test.txt` ; -m参数加输入注释，若文件已经存在可以直接commit
 

----------
## 版本查看、还原版本、状态查询 ##
 - `$ git log` ; 查看历史记录,原始的
 - `$ git log --oneline` ; 以一行的格式显示日志,部分hash，漂亮显示
 - `$ git reflog` ; 显示指针，方便还原到某一个历史版本
 - `$ git reset --hard 5df26ae` ; 返到5df26ae所在的版本
 - `$ git reset --hard HEAD` ; 全部同步到工作区的当前指针
 - `$ git status` ；查看git状态
 - tips:删除文件后也要git commit
 

----------
## 文件比较 ##
 - `$ git diff test.txt` ; 和暂存区比较
 - `$ git diff head test.txt` ; 和本地库进行比较，head与当前指针比较，可以该为hash和某一版本进行比较

----------
## 分支 ##
 - `$ git branch -v` ; 查看所有分支
 - `$ git branch one_branch` ; 创建一个one_branch分支
 - `$ git checkout one_branch` ; 切换到某一个分支
 - `$ git merge one_branch` ; 合并分支
 - tips:合并分支要切换到被合并的分支上，一般为master

----------
## 本地冲突的解决 ##
 1. 把代码修改为需要上传的样子，和你冲突的人协商
 2. `$ git add test.txt` ; 修改文件提交到暂存区
 3. `$ git commit -m " sfd"` ; 修改文件提交到本地库，不需要写文件名
 4. `$ git merge master` ; 合并分支
   
