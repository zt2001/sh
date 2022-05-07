#! /bin/bash
#下载apollo3.0压缩包
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

	echo "**********删除完毕**********"
	echo ""
	echo "apollo下载脚本已运行完毕"
	echo ""
	echo "*********sh.wyjs.ltd*********"
	echo ""
	exit 0

else
	echo ""
	echo "*************🌩*************"
	echo ""
	echo "apollo下载脚本已运行完毕"
	echo ""
	echo "*********sh.wyjs.ltd*********"
	echo ""
	exit 0
fi
