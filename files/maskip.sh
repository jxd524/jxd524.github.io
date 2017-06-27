#!/bin/shi


# IP 地址的一些操作,子网掩码的计算等功能
#
# 作者: Terry
# Email: jxd524@163.com
# Data: 2017-06-27 16:19
# 


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
        if [[ $(( mask & (1 << i) )) != 0 ]]; then
            nBit=$(( nBit + 1 ))
        else
            break
        fi
    done
    for (( ; i >= 0; i-- )); do
        if [[ $(( mask & (1 << i) )) != 0 ]]; then
            echo 0
            return
        fi
    done
    echo $nBit
}

# 获取指定IP,子网掩码下的所有有效IP地址,去掉全0,全1
# $1: IP地址
# $2: 子网掩码
# 返回: IP整形数值
function allIntranetIps()
{
    result=()
    ip=$(ipToNum $1)
    if [[ $ip == 0 ]]; then
        ip=$1
    fi

    mask=$(maskNum $2)
    if [[ $mask == 0 ]]; then
        echo ${result[@]}
        return
    fi

    nBaseIp=$(( ip & mask ))
    nMaskBit=$(maskNumBitCount $mask)
    nHostCount=$(( (1 << (32 - nMaskBit)) - 2 ))
    for (( i = 0; i < $nHostCount; i++ )); do
        result[i]=$(( nBaseIp + i + 1 ))
        #echo $(numToIp $(( nBaseIp + i + 1 )))
    done

    echo ${result[@]}
}

ips=$(allIntranetIps '172.168.80.142' '0xffffff00')
for x in ${ips[@]}; do
    echo $(numToIp $x)
done

