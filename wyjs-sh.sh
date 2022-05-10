#! /bin/sh
cd ~
if [ ! -f "wyjs-sh/main.sh" ]; then
tee -ai ~/.bashrc <<-'EOF'
alias wyjs='bash ~/wyjs-sh/main.sh'
EOF
    cd;mkdir wyjs-sh;cd wyjs-sh;rm main.sh;wget https://cdn.jsdelivr.net/gh/zt2001/sh@master/main.sh ;chmod 777 main.sh;echo ""
fi

#echo ''
#echo ''
#echo ''
#echo ''
#echo ''
#echo '**********************************************************'
#echo '*                                                        *'
#echo '*                  欢迎使用忘忧脚本                      *'
#echo '*                                                        *'
#echo "*             快捷指令 ' wyjs ' 来打开指令               *"
#echo '*                                                        *'
#echo "*  请重新打开终端或输入'source ~/.bashrc'后可执行该指令  *"
#echo '*                                                        *'
#echo '**********************************************************'
#echo ''
#echo ''
#echo ''
#echo ''
#echo ''
