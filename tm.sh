
#!/data/data/com.termux/files/usr/bin/bash
 
# 配置开机启动项
function initBoot(){
	echo
	echo "-->删除.bashrc文件"
	rm -f ~/.bashrc
	
	echo
	echo "-->配置sshd开机启动项"
	if isInstall "sshd"
	then
		echo '
		# 启动sshd
		if pgrep -x "sshd" >/dev/null
		then
			echo "--------------"
			echo "sshd运行中..."
			echo "--------------"
		else
			sshd >/dev/null
			echo "--------------"
			echo "sshd已开启..."
			echo "--------------"
		fi
		' >> ~/.bashrc
		echo "sshd 开机启动项配置完成"
	else
		echo "sshd 未安装"
	fi
	
	echo
	echo "-->配置mariadb开机启动项"
	if isInstall "mariadb"
	then
		echo '
		# 启动mariadb
		if pgrep -x "mysqld_safe" >/dev/null
		then
			echo "--------------"
			echo "mysql运行中..."
			echo "--------------"
		else
			mysqld_safe -u root >/dev/null  &
			echo "--------------"
			echo "mysql已开启..."
			echo "--------------"
		fi
		' >> ~/.bashrc
		echo "mariadb 开机启动项配置完成"
	else
		echo "mariadb 未安装"
	fi
	
	echo
	echo "-->配置ubuntu开机启动项"
	if test -e /data/data/com.termux/files/home/ubuntu-in-termux/startubuntu.sh
	then
		echo '
		# 启动Ubuntu系统...
		/data/data/com.termux/files/home/ubuntu-in-termux/startubuntu.sh
		' >> ~/.bashrc
		echo "ubuntu 开机启动项配置完成"
	else
		echo "ubuntu 未安装"
	fi	
 
	echo
	echo "-->使配置立即生效"
	source ~/.bashrc
}
 
# 设置mariadb的root用户密码，允许远程访问数据库
function initMariadb(){
	echo "-->修改root账户密码"
	while :
	do
		read -p "请输入root账户密码：" -s db_root_password
		if test -z "$db_root_password"
		then
			echo "密码不能为空"
		else
			break
		fi
	done
	
	echo
	echo "-->添加远程访问数据库的账户"
	while :
	do
		read -p "请输入远程访问数据库的用户名：" db_remote_username
		if test -z "$db_remote_username"
		then
			echo "用户名不能为空"
		else
			break
		fi
	done
	
	echo
	echo "-->输入$db_remote_username对应的密码"
	while :
	do
		read -p "请输入$db_remote_username账户密码：" -s db_remote_password
		if test -z "$db_remote_username"
		then
			echo "用户名不能为空"
		else
			break
		fi
	done
 
	echo
	mysql -u $(whoami) -e "use mysql;set password for 'root'@'localhost' = password('$db_root_password');CREATE USER '$db_remote_username'@'%' IDENTIFIED BY '$db_remote_password';GRANT ALL ON *.* TO '$db_remote_username'@'%';flush privileges;"
	
	echo "数据库账户信息："
	mysql -u $(whoami) -e "use mysql;select host,user,password from user;"
}
 
# 判断多个应用是否都安装成功
function isAllInstalled(){
	for((i=0;i<${#base_soft_array[@]};i++));do
		if isInstall ${base_soft_array[$i]}
		then
			continue
		else
			return 1
		fi
	done
}
 
# 判断应用是否安装成功
function isInstall(){
	if ! type $1 >/dev/null 2>&1; then
		echo "$1 未安装"
		return 1
	else
		echo "$1 已安装"
		return 0
	fi
}
 
 
command_info="
-----------------------------------------------------
执行Termux初始化安装配置脚本
输入以下指令编号，执行具体任务
0-退出
1-更换镜像源(清华)
2-安装基础软件(vim curl wget git tree proot openssh)
3-安装开发软件(jdk, mariadb)
4-安装ubuntu系统
5-配置开机启动项
6-Termux获取外部存储访问权限
ll-显示所有命令
-----------------------------------------------------
"
echo "$command_info"
echo
echo
echo
# 根据指令执行具体任务
while :
do
	echo
	read -p "请输入指令：" command
	case $command in
		0)
			echo "退出"
			break
			;;
		1)
			echo "(1)更换镜像源..."
			sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
			sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
			sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
			# 更新软件列表
			pkg update -y
			;;
		
		2)
			echo "(2)安装基础软件(vim curl wget git tree proot openssh)..."
			pkg install vim curl wget git tree proot openssh -y
			base_soft_array=("vim" "curl" "wget" "git" "tree" "proot" "openssh")
			if isAllInstalled $base_soft_array
			then
				echo "基础软件(vim curl wget git tree proot openssh)安装完成"
			else
				:
			fi
			;;
		3)  
			echo "(3)安装开发软件(jdk, mariadb)..."
			echo "(3.1)安装mariadb"
			read -p "输入yes安装安装mariadb：" mariadb_sure 
			if test $mariadb_sure = "yes"
			then
				pkg install mariadb -y
				# 启动mariadb
				if isInstall mariadb
				then
					echo "mariadb版本信息："
					mysql --version
					echo "启动mariadb"
					mysqld_safe -u root >/dev/null &
					echo
					echo "初始化mariadb"
					initMariadb
				else
					:
				fi
			else
				echo '已跳过安装:mariadb'
			fi
				
			echo "(3.2)安装jdk"
			read -p "输入yes安装jdk：" jdk_sure 
			if test $jdk_sure = "yes"
			then
				pkg install openjdk-17 -y
				echo "jdk版本信息："
				java -version	
			else
				echo '已跳过安装:jdk'
			fi
			;;
		4)  
			echo "(4)安装ubuntu系统"
			# 判断是否安装git,wget,proot
			soft_array=("git" "wget" "proot")
			if isAllInstalled $soft_array
			then
				# 执行安装ubuntu命令
				# 回到home目录
				cd ~
				# 克隆安装脚本
				git clone https://github.com/MFDGaming/ubuntu-in-termux.git
				# 跳转到ubuntu-in-termux目录
				cd ubuntu-in-termux
				# 授权
				chmod +x ubuntu.sh
				# 执行安装脚本
				./ubuntu.sh -y
			else
				echo "缺少必要的软件，建议先执行指令2"
			fi
			;;
		5)  
			echo "(5)配置开机启动项(sshd,mariadb,ubuntu)"
			read -p "原先配置将删除，输入yes确认：" init_sure 
			if test $init_sure = "yes"
			then
				initBoot
			else
				echo "取消配置开机启动项"
			fi
			;;
		6)  
			echo "(6)Termux获取外部存储访问权限"
			termux-setup-storage
			;;
		ll)  
			echo "$command_info"
			;;
		*)  
			echo '指令错误'
			continue
			;;
	esac
done
