#!/bin/bash
#Program:
#	First try!
#History:
#2020/03/12	Gu	644788074@qq.com
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/bin
export PATH

echo -e "\033[34m=================================\033[0m



 _   _   ___  _____  _   __ ___________ _____ _   _ 
| | | | / _ \/  __ \| | / /|  ___| ___ \  __ \ | | |
| |_| |/ /_\ \ /  \/| |/ / | |__ | |_/ / |  \/ | | |
|  _  ||  _  | |    |    \ |  __||    /| | __| | | |
| | | || | | | \__/\| |\  \| |___| |\ \| |_\ \ |_| |
\_| |_/\_| |_/\____/\_| \_/\____/\_| \_|\____/\___/ 
                                                    
                                                    



	Deepin系统一键部署渗透常用工具
	作者：Gu
	联系方式：644788074
	个人网站：http://hackergu.com
	
\033[34m==================================\033[0m"

echo -e "


"

read -p "请输入工具安装目录：" myhome
echo -e "============"
echo -e "验证目录合法性"
echo -e "============"
cd ${myhome}
if [ $? -eq 0 ];then
    echo -e "++++++此目录合法，可以使用++++++"
else
    echo -e "------此目录非法，请重新选择------s"
    exit 1
fi



function checkroot(){
	if [[ $EUID -ne 0 ]];then
		echo -e ""
		echo -e "------当前用户非root用户------"
        	echo -e "-----请以root身份执行该脚本-----"
		echo -e ""
		exit 1
	else
		echo -e ""
		echo -e "++++++root用户检查完毕++++++"
		echo -e ""
	fi
}


function network(){
	echo -e "测试网络连通性……"
	domain=www.baidu.com
	ping -c 3 -i 0.2 -w 3 $domain &> /dev/null
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++网络状态良好++++++"
		echo -e ""
	else
		echo -e ""
		echo -e "------无网络连接T^T------"
		echo -e ""
		exit 1
	fi
}

#开始正式进入主体，下载工具
##首先git工具是必须具备的

function gittool(){
    echo -e "开始安装git工具……"
	apt install git
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++git安装完毕++++++"
		echo -e ""
	else
		echo -e "------git安装失败，请重新安装------"
		exit 1
	fi
}

##安装curl
function curltool(){
    echo -e "开始安装curl工具……"
	apt install curl
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++curl安装完毕++++++"
		echo -e ""
	else
        echo -e ""
		echo -e "------curl安装失败，请重新安装------"
        echo -e ""
		exit 1
	fi
}




##安装msf
##deepin下的安装比centos下的安装要友好很多

function msf(){
    cd ${myhome}
	echo -e "Metasploit正在安装中……"
	wget https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb
    cp msfupdate.erb msfinstall
    rm -rf msfupdate.erb
    chmod 755 msfinstall
    ./msfinstall
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++Metasploit安装完成++++++"
		echo -e ""
	else
		echo -e ""
		echo -e "------Metasploit安装失败------"
		echo -e ""
	fi
}

##安装Nmap
##Nmap包含在自带源中

function nmap(){
	echo -e "Nmap正在安装中……"
	apt install nmap
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++Nmap安装完成++++++"
		echo -e ""
	else
		echo -e ""
		echo -e "------Nmap安装失败------"
		echo -e ""
	fi
}

##安装WPscan   目前出了问题，环境不支持
##做靶机的神器，不可缺少

function wpscan(){
    echo -e "WPscan正在安装中……"
    echo -e "配置ruby环境……"
    apt install ruby
    git clone https://github.com/wpscanteam/wpscan
    cd wpscan/
    bundle install && rake install
}


#安装mysql
function mysql(){
    echo -e "mysql正在安装中……"
    apt install mysql-client mysql-server
	if [ $? -eq 0 ];then
		echo -e ""
		echo -e "++++++Mysql安装完成++++++"
		echo -e ""
	else
		echo -e ""
		echo -e "------Mysql安装失败------"
		echo -e ""
	fi

}

#安装sqlmap

function sqlmap(){
    cd ${myhome}
    echo -e "Sqlmap正在安装中……"
    git clone https://github.com/sqlmapproject/sqlmap
    if [ $? -eq 0 ];then
        echo -e "++++++Sqlmap安装成功++++++"
    else
        echo -e "------Sqlmap安装未完成------"
    fi
    cd sqlmap
    pwd=`pwd`
    ln -s ${pwd}/sqlmap.py /usr/bin/sqlmap
    if [ $? -eq 0 ];then
        echo -e "++++++Sqlmap软链接建立完成++++++"
    else
        echo -e "------Sqlmap软链接建立失败------"
    fi
    
}


#安装hydra

function hydra(){
    cd ${myhome}
    echo -e "Hydra正在安装中……"
    git clone https://github.com/vanhauser-thc/thc-hydra
    cd thc-hydra
    ./configure
    make
    make install
    if [ $? -eq 0 ];then
        echo -e "++++++Hydra安装完成++++++"
    else
        echo -e "------Hydra安装失败------"
    fi
}

#安装netcat
function netcat(){
    apt install netcat
    if [ $? -eq 0 ];then
        echo -e "++++++netcat安装完成++++++"
    else
        echo -e "------netcat安装失败------"
    fi   
}

#安装dirsearch，这是一款非常强大的目录扫描工具

function dirsearch(){
    cd ${myhome}
    echo -e "Dirsearch正在安装中……"
    git clone https://github.com/maurosoria/dirsearch
    if [ $? -eq 0 ];then
        echo -e "++++++Dirsearch安装成功++++++"
    else
        echo -e "------Dirsearch安装未完成------"
    fi
    cd dirsearch
    pwd=`pwd`
    ln -s ${pwd}/dirsearch.py /usr/bin/dirsearch
    if [ $? -eq 0 ];then
        echo -e "++++++Dirsearch软链接建立完成++++++"
    else
        echo -e "------Dirsearch软链接建立失败------"
    fi
}

#安装weevely，webshell管理工具

function weevely(){
    cd ${myhome}
    echo -e "Weevely正在安装中……"
    git clone https://github.com/epinna/weevely3
    if [ $? -eq 0 ];then
        echo -e "++++++weevely安装成功++++++"
    else
        echo -e "------weevely安装未完成------"
    fi
    cd weevely3
    pwd=`pwd`
    ln -s ${pwd}/weevely.py /usr/bin/weevely
    if [ $? -eq 0 ];then
        echo -e "++++++weevely软链接建立完成++++++"
    else
        echo -e "------weevely软链接建立失败------"
    fi
}

#安装searchsploit

function searchsploit(){
    cd ${myhome}
    echo -e "searchsploit正在安装中……"
    git clone https://github.com/offensive-security/exploitdb
    if [ $? -eq 0 ];then
        echo -e "++++++searchsploit安装成功++++++"
    else
        echo -e "------searchsploit安装未完成------"
    fi
    cd exploitdb
    pwd=`pwd`
    ln -s ${pwd}/searchsploit /usr/bin/searchsploit
    if [ $? -eq 0 ];then
        echo -e "++++++searchsploit软链接建立完成++++++"
    else
        echo -e "------searchsploit软链接建立失败------"
    fi
    
}



checkroot
network
gittool
curltool
msf
nmap
mysql
sqlmap
hydra
netcat
dirsearch
weevely
searchsploit
