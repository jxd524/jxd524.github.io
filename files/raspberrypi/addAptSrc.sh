#!/usr/bin/env bash

#   树莓派 apt-get 设置为中科大的镜像源
#
#   作者: Terry
#   日期: 2017-06-28 16:55
#   Blog: http://icc.one/
#   Email: jxd524@163.com
#

echo "set apt-get source"
echo "deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee /etc/apt/sources.list
echo "deb-src http://mirrors.ustc.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee -a /etc/apt/sources.list
echo "deb https://mirrors.ustc.edu.cn/archive.raspberrypi.org/ jessie main ui" | sudo tee /etc/apt/sources.list.d/raspi.list

echo "begin apt-get update"
sudo apt-get update

echo "begin apt-get upgrade"
sudo apt-get upgrade -y
