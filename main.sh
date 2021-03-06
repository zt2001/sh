#! /bin/bash
sudo -v
while ((1))
do
	echo ""
	echo "**********wyjs-sh**********"
	echo ''
	echo "1.编译apollo容器"
	echo "2.进入apollo容器"
	echo "3.安装docker"
	echo "4.docker镜像加速"
	echo "5.下载apollo"
	echo "6.修改sudo无需密码"
	echo "其他字符.退出"
	echo ''
	echo '************菜单************'
	read -p "请输入您的选择:" value
	echo ''
	if [ "$value" == "1" ]; then
		cd
		cd work/ApolloAuto/apollo
		bash docker/scripts/dev_start.sh
		echo ""
		echo "编译完毕"
		echo ""
		echo ""
		exit 0

	elif [ "$value" == "2" ]; then
		echo ""
		echo "**********进入中**********"
		echo ""
		echo "进入中"
		echo ""
		echo ""
		cd
		cd work/ApolloAuto/apollo
		bash docker/scripts/dev_into.sh
		exit 0

	elif [ "$value" == "3" ]; then
		cd
		cd work/ApolloAuto/apollo
		bash docker/setup_host/setup_host.sh
		bash docker/setup_host/install_docker.sh
		echo ""
		echo "docker安装完毕"
		echo ""
		echo ""
		exit 0

	elif [ "$value" == "4" ]; then
		sudo mkdir -p /etc/docker
		cd /etc/docker/
		sudo rm daemon.json
		sudo wget https://fastly.jsdelivr.net/gh/zt2001/sh@main/daemon.json
		sudo systemctl daemon-reload
		sudo systemctl restart docker
		echo ""
		echo "修改docker镜像加速完毕"
		echo ""
		echo ""
		exit 0

	elif [ "$value" == "5" ]; then
		cd ~
		wget https://archive.fastgit.org/ApolloAuto/apollo/archive/refs/tags/v3.0.0.zip
		#解压
		unzip -o v3.0.0.zip
		#重命名剪贴到新路径
		mkdir work && mkdir work/ApolloAuto
		mv apollo-3.0.0 work/ApolloAuto/apollo
		#删除压缩包
		read -p "是否删除压缩包(Y/N/其他):" value
		if [ "$value" == "Y" ] || [ "$value" == "y" ]; then
			rm -rf v3.0.0.zip
			echo ""
			echo "删除完毕"
			echo ""
			echo ""
			exit 0
		else
			echo ""
			echo "*************🌩*************"
			echo ""
			echo "          apollo下载完毕        "
			echo ""
			echo "*********sh.wyjs.ltd*********"
			echo ""
			exit 0
		fi
		echo ""
		echo "Apollo下载完毕"
		echo ""
		exit 0

	elif [ "$value" == "6" ]; then
		read -p "请输入当前用户名:" name
		if [ "$name" != "" ]; then
			sudo sed -i '/%sudo/a\'${name}' ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers
		else
			echo "********您未输入用户名*********"
		fi
		echo ""
		echo "修改完毕完毕"
		echo ""
		echo ""
		exit 0

	

	elif [ "$value" == "0" ]; then
		echo ""
		echo "正在退出"
		echo "*****"
		echo "**********"
		echo ""
		break
		exit 0
	else
		echo ""
		echo "******************************************"
		echo ""
		echo "     输入错误，输入的选项不在范围内      "
		echo ""
		echo "***************sh.wyjs.ltd****************"
		echo ""
	fi
done
echo ""
echo "******************************************"
echo ""
echo "             wyjs-sh脚本已运行完毕            "
echo ""
echo "***************sh.wyjs.ltd****************"
echo ""