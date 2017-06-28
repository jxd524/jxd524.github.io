#!/usr/bin/env bash

echo "set apt-get source"
echo "deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee /etc/apt/sources.list
echo "deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee -a /etc/apt/sources.list

echo "begin apt-get update"
sudo apt-get update

echo "begin apt-get upgrade"
sudo apt-get upgrade -y
