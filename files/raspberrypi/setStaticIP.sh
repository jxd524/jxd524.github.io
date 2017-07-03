#!/usr/bin/env bash


# 自动设置树莓派的静态IP地址
#
# 作者: Terry
# Email: jxd524@163.com
# Data: 2017-06-30 16:30
# 



echo "set static ip"

# 将整数转成IP址
# $1: 整形
# 返回: IP地址
function numToIp()
{
    num=$1
    a=$(( (num & 0xFF000000) >> 24 ))
    b=$(( (num & 0x00FF0000) >> 16 ))
    c=$(( (num & 0x0000FF00) >> 8 ))
    d=$((  num & 0x000000FF ))

    echo "$a.$b.$c.$d"
}

# 将点分十进制的IP转出整形
# $1: 点分十进制的IP
# 返回: IP地址的整形值
function ipToNum()
{
    n=0
    result=($( echo $1 | awk -F "." '{print $1, $2, $3, $4}' ))
    if [[ ${#result[@]} == 4 ]]; then
        n=${result[3]}
        local bit=24
        for (( i = 0; i < 3; i++ )); do
            n=$(( n + (result[i] << bit) ))
            bit=$(( bit - 8))
        done
    fi
    echo $n
}


# 获取子网掩码的整形值
# $1: 支持以下类型
#       1: 16进制, eg 0xFFFFFF00
#       2: IP地址, eg 255.255.255.0
#       3: IP地址+位数 eg 255.255.255.0/24
# 返回: IP地址的整形值
function maskNum()
{
    p=$1
    n16=$( echo $p | grep -i '0x' )
    if [[ ${#n16} != 0 ]]; then
        #0xFFFFFF00
        n=$( printf %d $n16 )
        echo $n
        return
    fi

    nBit=0
    ip=$( echo $p | grep '/' )
    if [[ ${#ip} != 0 ]]; then
        #255.255.255.0/24
        nBit=${p#*/}
        nResult=0

        if [[ $nBit -ge 8 && $nBit -le 30 ]]; then
            i=31
            while [[ $nBit -gt 0 ]]; do
                nResult=$(( nResult + (1 << $i) ))
                nBit=$(( nBit - 1 ))
                i=$(( i - 1 ))
            done
        fi
        echo $nResult
        return
    fi

    echo $(ipToNum $p)
}

# 获取子网掩码的位数
# $1: 整形
# 返回: 几个1, 0表示无效的子网掩码
function maskNumBitCount()
{
    mask=$1
    nBit=0
    i=31
    for (( ; i >= 0; i-- )); do
        if [ $(( mask & (1 << i) )) != 0 ]; then
            nBit=$(( nBit + 1 ))
        else
            break
        fi
    done
    for (( ; i >= 0; i-- )); do
        if [ $(( mask & (1 << i) )) != 0 ]; then
            echo 0
            return
        fi
    done
    echo $nBit
}

netInfo=($( ifconfig -s | awk 'BEGIN {nIndex=0} {if (nIndex++ > 0) print $1}' ))
for item in ${netInfo[@]}; do
    ips=($( ifconfig $item | grep "inet addr" | grep "Bcast" | awk -F ' ' '{print $2, $3, $4}' ))
    if [ ${#ips[@]} == 3 ]; then
        ip=$( echo ${ips[0]} | awk -F ':' '{print $2}' )
        mask=$( echo ${ips[2]} | awk -F ':' '{print $2}' )
        maskN=$( maskNum $mask)
        bitCount=$( maskNumBitCount $maskN )
        ipMask=$ip'/'$bitCount
        ipNum=$( ipToNum $ip )
        routeNum=$(( ($ipNum & 0xFFFFFF00) + 1 ))
        routeIp=$( numToIp $routeNum )

        echo "设置网卡${item}的静态IP为: ${ip}"
        echo "interface "$item >> /etc/dhcpcd.conf
        echo "static ip_address="$ipMask >> /etc/dhcpcd.conf
        echo "static routers="$routeIp >> /etc/dhcpcd.conf
        echo "static domain_name_servers=114.114.114.114 8.8.8.8" >> /etc/dhcpcd.conf

        echo "重启网卡可以使用命令: sudo ifconfig ${item} down && sudo ifconfig ${item} up"
    fi
done
