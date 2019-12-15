# Git学习

首先创建一个空的文件夹，使用Git Bash进入文件夹，执行初始化命令。

```git
$ git init
```

命令意思为将本文件夹升级为一个git仓库，执行后会发现多出了一个.git文件夹



使用git add命令，把文件添加到仓库

```git
$ git add readme.txt
```

用命令git commit告诉Git, 把文件提交到仓库

```git
$ git commit -m "first commmit"
```

-m参数后面输入的是本次提交的说明，最后能够写一些有意义的内容



使用git log查看历史记录 （按Q退出）

```git
$ git log
```

加上--pretty=oneline参数，可以一行显示

```git
$ git log --pretty=oneline
```



在Git中，用HEAD表示当前版本，上一个版本为HEAD^^,上上一个版本就是HEAD^^^,当前往上100个版本为HEAD~100。所以可以用git reset命令回退到上一个版本。

```git
$ git reset --hard HEAD^
```

也可以将参数HEAD^替换为某一个版本的commit  id（版本号）

若不清楚某一个版本的commit  id，则可以使用git reflog查看

```git
$ git reflog
```



Git有三个区间：工作区（Working Directory）-> 暂存区（Stage）-> master

git add命令是将工作区的文件提交到暂存区，git commit命令是提交更改，就是将暂存区的所有内容提交到当前分支master

可以使用git status命令查看状态

```git
$ git status
```

使用git diff查看工作区和暂存区文件的区别

```git
$ git diff
```



使用git checkout -- file可以丢弃工作区的修改

```git
$ git checkout -- test.txt
```

一种是自修改后还没有被放到暂存区，撤销修改就回到和版本库一摸一样的状态

一种是已经添加到暂存区后，又作了修改，撤销修改就回到添加到暂存区后的状态



使用git rm 删掉工作区和暂存区文件，并且git commit

```git
$ git rm test.txt
$ git commit -m "remove text.txt"
```



关联GitHub仓库（空仓库）

```git
$ git remote add origin git@github.com:yongjitao/Learn.git
```

把本地库的内容推送到远程

```git
$ git push -u origin master
```

由于远程仓库是空的，第一次推送master分支时，加上-u参数，Git不但会把本地的master分支内容推送到远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后推送的时候，直接使用git push

```git
$ git push
```



使用git clone可以克隆一个本地库

```git
$ git clone git@github.com:yongjitao/Learn.git
```



Git中每一次提交。Git都会把它们串成一条时间线，这条时间线就是一个分支，也叫主分支，即master分支。HEAD指向master，master指向提交。HEAD也可以指向其它分支来代表当前分支。分支与分支之间可以合并。

查看所有分支，前面有*号的是当前分支

```java
$ git branch
```

创建一个dev分支

```git
$ git branch dev
```

将当前分支切换到dev

```git
$ git switch dev
```

创建分支+切换分支

```git
$ git switch -c dev
```

在dev分支上做出一些文件修改后，切换回master分支，会发现dev分支中的内容不见了，使用git merge将指定分支合并到当前分支

```git
$ git merge dev
```

删除分支

```git
$ git branch -d dev
```

因为创建、合并和删除分支非常快，如果需要可以使用分支完成某个任务，合并后再删掉分支，这和直接在master分支上工作效果一样，但过程更加安全。

