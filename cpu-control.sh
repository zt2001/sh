#!/bin/sh
#脚本功能：每过6秒检测一次，当cpu温度低于42℃时，调整cpu频率为400MHz-1540MHz之间；高于46℃时，调整cpu频率为400MHz-800MHz之间。
#引入i、j变量，防止重复执行调频命令。
i=1 #低温提高主频
j=0 #高温降低主频
while true
do
   
set -- $(cat /sys/class/thermal/thermal_zone0/temp \
             /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    TEMP=$1
    GOVERNOR=$2
    if [ "$TEMP" -le 42000 ] && [ "$GOVERNOR" = "ondemand" ] && [ $i -eq 1 ]; then
        cpufreq-set -d 400MHz -u 1540MHz
        echo "已升频"
        i=0
        j=0
    fi
   
    if [ "$TEMP" -ge 46000 ] && [ "$GOVERNOR" = "ondemand" ] && [ $j -eq 0 ]; then
        cpufreq-set -d 400MHz -u 800MHz
        echo "已降频"
        i=1
        j=1
    fi
   
    echo "当前cpu温度：" $(($TEMP / 1000))"℃"
    echo $i $j "【提示：1 1处于降频状态；0 0处于升频状态；1 0处于初始状态】"
   
sleep 6
done
