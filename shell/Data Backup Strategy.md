# Data Backup Strategy

## 前言

### Developers

Developed by: Yuan Zhen

Supervisors: Pro. Fangjie Zhu

Horticultural Plant Biology and Metabolomics Center,Haixia Institute of Science and Technology,Fujian Agriculture and Forestry University

----------------------------------------------------------------------------------------------------------------------------------------

这本小册子介绍如和通过基本的命令来设置系统和备份，同时，如果你的Linux某一天被黑客袭击了或者你错误的修改了系统的配置文件，导致你的系统奔溃了。在这个时候，如果你有备份的数据，那么就美滋滋，你用来恢复系统的时间和成本就会大大降低。不会像我在今天（2021年6月8日）使系统奔溃了，但是手足无措。那么那些文件最需要备份？备份时需要完整的备份还是仅仅备份重要的数据？咱们现在就开始学习一下。

------



###  可以阅读看看的参看文献

- [tutorialspoint](https://www.tutorialspoint.com/linux_admin/linux_admin_backup_and_recovery.htm)
- [The 15 Best Backup Software For Linux Desktop](https://www.ubuntupit.com/best-backup-software-for-linux/)
- [Btrfs](https://wiki.archlinux.org/title/Btrfs)
- [鸟哥的Linux私房菜(繁体字)](http://linux.vbird.org/linux_basic/0610hardware.php)



## 备份要点

### 备份数据的考虑

如果你需要重新安装系统的时候，备份的好坏会影响到你恢复系统的进度。那么首先，咱们得了解系统为啥回损坏。说来惭愧，我上次就是应为错误删除系统配置文件，而导致系统崩溃。说的学术点，系统可能因为**不可预期的伤害而导致系统发生错误**，这就包括：硬盘坏掉、软件问题导致系统出错、人为操作不当或者其它因素。

***==Even a very powerful operating system cannot cope with random deletion by system administrators !!==!***

***==Even a very powerful operating system cannot cope with random deletion by system administrators !!==!***

***==Even a very powerful operating system cannot cope with random deletion by system administrators !!!==***



- 硬件问题

  **计算机是一个不可靠的东西** ，看到一本书这样讲，感觉是有点玄学吧。一般来说，造成系统损坏得硬件组件应该使硬盘了，因为其他组件坏掉时，会影响到系统的运行，不过我们的数据还在硬盘中。

- 软件与人为问题

  ==***用户操作不当对系统软件会造成最严重伤害***== （就是我这样傻乎乎地删除了系统配置文件）。就像解决问题的最好办法就是解决提出问题的人，高手厌烦你的低级代码错误，直接给你一行命令：`sudo rm -rf /*`，如果你真的这样做，赶紧收拾东西跑路吧。对于世界上某些闲人（黑客）攻击，也会使得你的系统奔溃。



就像咱们价格昂贵的测序数据，各种Seq分析的脚本，万一丢失了岂不是一个巨大的损失。首先了解一下备份呗。

- 主机角色不同，备份任务也就不同

  那么每一台主机都需要备份？多久备份一次？要备份什么数据？

  类似Ghost这样的单机备份软件就是将你系统上的磁盘数据完整地复制，可以使用USB外接磁盘备份，只要将USB磁盘连接到主机就可以恢复了。

  如果主机提供了Internet在线服务，例如你在一条微博下评论，但是某天那条微博评论区奔溃了，而你那条极其重要地可以改你的内心小世界的评论找不回来咋办，总不能哇的一下哭起来了吧。所以建立备份策略（频率、媒介、方法等）时非常有必要的。

- 备份因素考虑

  目前计算机（操作频率高、硬件良率差、用户操作习惯不良（也有是我这种Linux知识掌握模棱两可的半吊子用户）、某些操作系统的宕机率太高）的稳定性差。所以备份的时候要充分考虑可能的因素。

- 备份那些文件

  那些对你非常重要的数据，比如/etc/*或者/home,或者女朋友给你信

- 选择什么样的备份媒介

  可擦写硬盘？另一块硬盘？同一块硬盘不同分区？还是使用网络备份系统？那个最快、最安全、最省钱、保存时间最长？

- 备份的方式

  完整备份？还是差异备份（后面章节具体讲）仅备份又被修改的数据即可？

- 备份的频率

  天天备份？完整备份的话，多久才合适？

- 备份使用的工具

  tar、cpio、dd还是dump等备份工具？



### 哪些数据值得备份

那么那些是重要的关键数据备份你？大致可以分为两大类：

- 系统基本设置信息
- 类似网络服务的内容数据

#### 操作系统本身需要备份的文件

这方面的文件主要是与【账号与系统配置文件】有关。分为五类`/etc/passwd`、`/etc/shadow`、`/etc/group`、`/etc/gsshadow`、`/home`下面的用户家目录等。一般的话，将/etc整个目录备份下来的话准没错，这样几乎所有配置文件都可以被保存。

/home使用户的家目录，而且如果用户会有邮件的话，也需要保存/var/spool/mail/内容也需要备份。如果你修改过内核，那么/boot里面的信息也很重要。

所以归纳一下内容必须备份：

- /etc/整个目录
- /home/整个目录
- /var/spool/mail/
- /var/spoll/{at|cron}/
- /boot/
- /root/
- 如果你自行安装过其他软件，那么/usr/local/或者/opt也最好备份一下

#### 网络服务的数据库方面

如果你的网络软件都是以原厂提供为主，配置文件都在/etc/下面。如果你是自行安装的话，那么/usr/local这个文件夹就非常重要了。用户主动提供的文件，以及服务运行过程中会产生的数据，都需要被考虑来备份。所以以下的建议来备份：

- 软件本身的配置文件：/etc/整个目录以及/usr/local/整个目录
- 软件服务提供的数据
  - WWW数据：/var/www整个目录或者/srv/www整个目录，以及系统用户的家目录
  - MariaDB:/var/lib/mysql整个目录
- 其他在Linux主机上面提供的服务的数据库文件



总的来说，你需要保存以下软件：`/etc`、`/home`、`/root`、`/var/spool/mail/`、`/var/spool/cron/`、`/var/spool/at/`、`/var/lib/`这些文件目录建议被保存。而`/dev`看你啰。

### 备份用储存媒介的选择

选择一个数据存放的地方，也显得非常重要。

- 异地备份系统

  说的简单一点就是将你的系统数据备份到其他的地方去。我可以把学校的东西备份到我家的电脑里面去的。但是着个操作很受带宽的影响。如果你的带宽足够好的话，可以考虑。但是，咱们中心的WIFI实在是太差了，还经常断线，嗐！！

- 存储媒介的考虑

  在过去使用的存储媒介可能有Tape、MO、ZIP、CD-RW、DVD-RW、外接式磁盘以及外接NAS储存设备（等价于一台小型的Linux服务器）

  经费充足的情况下，可以使用NAS。经费不足，现在磁盘都有4TB以上的容量，那一块磁盘通过外接式USB接口，搭配USB3.0来传输，也很美滋滋。这样处理方式怕单块磁盘损坏，可以买两三块互相轮流备份，如果想保存较长时间斌且不怕消磁和发霉，磁带也是个不错选择。



## 备份的种类、频率与工具的选择

那么备份的方式有哪些呢？一般可以粗略的分为：累计备份和差异备份。如果你在系统出错时，想要重新安装到更新的系统时，仅备份关键数据就行。

### 累积备份

如果仅备份关进啊数据，那么你要在系统出错后，再去找新的Linux发行版本来安装，安装完毕后海奥考虑到数据新旧版本差异的问题。还得要进行数据的移植与系统服务的重新建立等。等到建立完成后，还要进行相关的测试。

- 还原的考虑

  若硬件出问题导致系统损坏，调用（如使用dd命令）备份，甚至连系统都不需要重装

- 原则

  但是当你系统用的非常久，产生了大量的数据时，累计备份所花费的时间和储存媒介的使用就显得十分麻烦。

  在累计备份当中，指的是：系统在进行完第一次完整备份后，经过一段时间的运行，比较系统与备份文件之间的差异，仅备份有差异的文件就行。而第二次累积备份则与第一次累计备份的数据比较，也是仅备份有差异的数据而已。

  举个栗子：星期一我做好了完整备份，周二累计备份就是在周一的完整备份的基础上备份差异的数据。周三备份与周二差异的数据，依次累积（我在周一有1.txt、2.txt，我在周二生成了3.txt，那么会把3.txt累积到周一备份里面，这样备份就有1.txt、2.txt、3.txt这三个文件了）

- 还原

  如果你周四的时候，系统奔溃了，那么你的首先万元周一完整的备份，然后完成周二、周三的累积备份，这样才能完全恢复

- 常用还原软件

  有dd、cpio、xfsdump/xfsrestore等，这些工具都能备份设备与特殊的文件。

  - dd可以直接读取磁盘的扇区（sector）而不理会文件系统，速度很慢
  - cpio能够备份所有文件名，得配合find或其他找文件的命令才可。
  - 上面两个得完整备份需要使用脚本，而xfsdump可直接进行



```bash
##用dd将/dev/sda备份到/yuanzhen,不必格式化，但是很慢
dd if=/dev/sda of=/yuanzhen
##使用cpio来备份与还原系统，假设储存媒介为SATA磁带机
find / -print | cpio -covB > /dev/st0 ####备份
cpio -iduv < /dev/st0 ####还原
##将/home独立文件系统备份到/yuanzhen独立用来备份得文件系统
xfsdump -l 0 -L 'full' -M 'full' -f /yuanzhen/home.dump /home  ###完整备份
xfsdump -l 1 -L 'full-1' -M 'full-1' -f /yuanzhen/home.dump1 /home ###第一次累计备份

##tar也可以考虑备份正系统，除了不需要得/proc、/mnt、/tmp目录
tar --exclude /proc --exclude /mnt --exclude /tmp \
> --exclude /yuanzhen -jcvp -f /yuanzhen/system.tar.bz2 /
```



### 差异备份

也是需要第一次完整备份后才能够进行，只不过每一次备份都是与原始得完整备份比较的结果，所以系统运行得越长，离完整备份时间越长，那么差异备份数据就越大。

所以，如果使用xfsdump来备份的话，每次备份得等级都是1.

```bash
tar -N '2021-06-08' -jpcv -f /yuanzhen/home.tar.bz2 /home
###使用tar得-N来备份比20210608还要新得文件会被备份下来
```



还可使用rsync来进行镜像备份，比较快

```bash
rsync -zv /home /yuanzhen/
####将/home目录备份到/yuanzhen目录，且在此目录下会产生/home目录
```



综上所述，差异备份需要的磁盘容量可能会比累积备份到，但是还原速度快



### 关键数据备份

完整备份虽然挺棒，但是花费时间比较长。主机提供得服务并不是一定在24小时提供，我们只需要备份关键数据就行。由于完整备份可能是在系统运行期间进行，不但会花费更多的时间，而且如果当你备份时系统已经被攻击，那么你备份得数据是有问题的，那么还原回去也是有问题得系统。



如果，仅是备份关键数据，那么由于系统得绝大部分执行文件都可以后来重新安装，因此你的系统不是硬件问题而是软件问题而导致系统备份攻击或者损坏时，直接使用最新得Linux发行版本，然后重装，然后将系统数据（账号密码与家目录等）与服务数据（/www/email/crontab/ftp)一个一个填回去即可。

## 备份脚本文件

首先来了解备份策略

- 主机硬件：使用一个独立得文件系统来储存备份数据，将此文件系统挂载到/yuanzhen当中
- 每日进行：备份经常变动性数据
- 每周进行：包括/home、/var、/etc、/boot、/usr/local等目录与特殊服务目录
- 自动处理：利用/etc/crontab来自动进行备份
- 异地备份：每月定期将数据：1）刻在光盘上，2）使用网络传输到另一台机器上



***每周更新***

```bash

#!/bin/bash
# ====================================================================
# 使用参数输入位置：
# basedir=用来储存这个脚本预计备份资料得目录(需要独立文件系统)
basedir=/backup/weekly  <==只需要改变这里！

# ====================================================================
###环境变量得取舍根据实际情况来定，可不要下面两行
PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C
###底下就不要改了鸭
# 设定要备份得服务的配置文件，以及备份得目录
named=$basedir/named
postfixd=$basedir/postfix
vsftpd=$basedir/vsftp
sshd=$basedir/ssh
sambad=$basedir/samba
wwwd=$basedir/www
others=$basedir/others
userinfod=$basedir/userinfo
# 判断目录是否存在，若不存在则自动建立。
for dirs in $named $postfixd $vsftpd $sshd $sambad $wwwd $others $userinfod
do
	[ ! -d "$dirs" ] && mkdir -p $dirs
done

# 1. 将系统得主要服务的配置文件分别备份下来，同时也备份 /etc 全部。
cp -a /var/named/chroot/{etc,var}	$named
cp -a /etc/postfix /etc/dovecot.conf	$postfixd
cp -a /etc/vsftpd/*			$vsftpd
cp -a /etc/ssh/*			$sshd
cp -a /etc/samba/*			$sambad
cp -a /etc/{my.cnf,php.ini,httpd}	$wwwd
cd /var/lib
  tar -jpc -f $wwwd/mysql.tar.bz2 	mysql
cd /var/www
  tar -jpc -f $wwwd/html.tar.bz2 	html cgi-bin
cd /
  tar -jpc -f $others/etc.tar.bz2	etc
cd /usr/
  tar -jpc -f $others/local.tar.bz2	local

# 2. 关于使用者参数方面
cp -a /etc/{passwd,shadow,group}	$userinfod
cd /var/spool
  tar -jpc -f $userinfod/mail.tar.bz2	mail
cd /
  tar -jpc -f $userinfod/home.tar.bz2	home
cd /var/spool
  tar -jpc -f $userinfod/cron.tar.bz2	cron at
```



***每日更新***

```bash
#!/bin/bash
# =========================================================
# 输入你想让备份数据放置到那个独立得目录中
basedir=/backup/daily/  <==你只要改这里就可以了！

# =========================================================
PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C
basefile1=$basedir/mysql.$(date +%Y-%m-%d).tar.bz2
basefile2=$basedir/cgi-bin.$(date +%Y-%m-%d).tar.bz2
[ ! -d "$basedir" ] && mkdir $basedir

# 1. MysQL (资料目录在 /var/lib/mysql)
cd /var/lib
  tar -jpc -f $basefile1 mysql

# 2. WWW 的 CGI 程序(如果有使用 CGI 程序的话)
cd /var/www
  tar -jpc -f $basefile2 cgi-bin
```



***远程更新***

```bash
#!/bin/bash
remotedir=/home/backup/
basedir=/backup/weekly
host=59.79.233.208
id=yuanzhen

###下面为程序，不需要修改
rsync -av -e ssh $basedir ${id}@${host}:${remotedir}
```



## 使用Btrfs文件系统

### 下载

要使用一些用户空间工具的话，需要 [安装](https://wiki.archlinux.org/title/Install) 基础操作必须的 [btrfs-progs](https://archlinux.org/packages/?name=btrfs-progs) 软件包。

如果需要从 Btrfs 文件系统引导（比如说内核和内存盘在一个 Btrfs 的分区上），请检查 [启动引导器](https://wiki.archlinux.org/title/Arch_boot_process_(简体中文)) 是否支持 Btrfs。



