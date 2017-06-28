#!/usr/bin/env bash

sudo echo "deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee /etc/apt/sources.list
sudo echo "deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ jessie main non-free contrib" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
apt-get upgrade -y
