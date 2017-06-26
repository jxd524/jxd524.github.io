#!/bin/sh

# 用于获取本机IP地址,子网掩码,广播地址
#
# 支持参数: 
#   s, -s: 带上表示不要显示说明信息,只显示获取到的信息
# 作者: Terry
# Email: jxd524@163.com
# Data: 2017-06-26 16:19
# 

bSilent=0
while getopts "s" arg ; do
    case $arg in
        s )
            bSilent=1
            ;;
    esac
done

if [[ $bSilent -eq 0 ]]; then
    echo "自动获取本机IP地址, MAC地址"
fi

ipInfo=( $(ifconfig | grep inet | grep netmask | grep broadcast | \
    awk '{                      \
    split($0, ary, " ");        \
    for (i in ary){             \
       if (i % 2 == 0)          \
            print ary[i]        \
    }                           \
}'))
len=`expr ${#ipInfo[@]} / 3`
if [ ${len} == 0 ]; then
    echo "没有找到相关信息"
    exit
fi

_Print() {
    printf "%-20s%-20s%-30s\n" $1 $2 $3
}

if [[ $bSilent -eq 0 ]]; then
   _Print "IP" "MASK" "Broadcast"
fi
i=0
while [[ ${len} > 0 ]]; do
    ip=${ipInfo[$i]}
    let "i += 1"
    mask=$(tr "[a-z]" "[A-Z]" <<< ${ipInfo[$i]})
    let "i += 1"
    broadcast=${ipInfo[$i]}
    let "i += 1"
    let "len -= 1"
    _Print $ip $mask $broadcast
done
