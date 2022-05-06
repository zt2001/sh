#! /bin/bash
sudo -v
read -p "1.编译apollo容器-2.进入apollo容器，3.安装docker，4.docker镜像加速，其他字符.退出:" value
if [ "$value" == "1" ]; then
	cd
	cd work/ApolloAuto/apollo
	bash docker/scripts/dev_start.sh
	echo ""
	echo "**********编译完毕**********"
	echo ""
	echo "容器脚本已运行完毕"
	echo ""
	echo "********sh.wyjs.ltd*********"
	echo ""
	pwd
	exit 0

elif [ "$value" == "2" ]; then
	echo ""
	echo "**********运行完毕**********"
	echo ""
	echo "容器脚本已运行完毕"
	echo ""
	echo "********sh.wyjs.ltd*********"
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
	echo "**********docker完毕**********"
	echo ""
	echo "容器脚本已运行完毕"
	echo ""
	echo "**********sh.wyjs.ltd*********"
	echo ""
	pwd
	exit 0

elif [ "$value" == "4" ]; then
	sudo mkdir -p /etc/docker
	cd /etc/docker/
	sudo rm daemon.json
	sudo wget https://fastly.jsdelivr.net/gh/zt2001/sh@main/daemon.json
	sudo systemctl daemon-reload
	sudo systemctl restart docker
	echo ""
	echo "**********删除完毕**********"
	echo ""
	echo "容器脚本已运行完毕"
	echo ""
	echo "********sh.wyjs.ltd*********"
	echo ""
	pwd
	exit 0
else
	echo ""
	echo "**********🌩**********"
	echo ""
	echo "容器脚本已运行完毕"
	echo ""
	echo "******sh.wyjs.ltd******"
	echo ""
	pwd
	exit 0
fi
