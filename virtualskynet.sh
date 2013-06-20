#! /bin/bash
PASSWORD=p4ssw0rd

echo -e ""
echo -e "\e[1;31m  -  VirtualSkynet CentOS AutoInstall Script  -  \e[0m"
echo -e ""

echo -e "\e[1;31m  -  Disable Selinux Runtime  -  \e[0m"
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

echo -e "\e[1;31m  -  Installing Linux Tools  -  \e[0m"
yum -y install htop  vim-enhanced  wget

echo -e "\e[1;31m  -  Instaling Up Database Server  -  \e[0m"
yum -y install mysql mysql-server
service mysqld start
chkconfig mysqld on
#echo "bind-address=0.0.0.0" >> /etc/my.cnf
echo "lower_case_table_names = 1" >> /etc/my.cnf
mysql -e " DROP DATABASE TEST "
mysql -e " DROP DATABASE test "
mysql -e " CREATE DATABASE virtualskynet "
#mysql -e " GRANT ALL ON *.*  TO 'root'@'%'  IDENTIFIED BY '${PASSWORD}' "
mysql -e " GRANT ALL ON *.*  TO 'root'@'localhost'  IDENTIFIED BY '${PASSWORD}' "


echo -e "\e[1;31m  -  Installing Java JDK  -  \e[0m"
rpm -ivh http://uni-smr.ac.ru/archive/dev/java/SDKs/sun/j2se/7/jdk-7u21-linux-x64.rpm

echo -e "\e[1;31m  -  Installing VirtualSkynet Server  -  \e[0m"
wget http://apache.osuosl.org/tomee/tomee-1.5.2/apache-tomee-1.5.2-plus.tar.gz
tar xfz apache-tomee-*.tar.gz
rm -rf apache-tomee-*.tar.gz
mv apache-tomee-* virtualskynet
cd virtualskynet
rm -rf LICENSE  NOTICE  RELEASE-NOTES  RUNNING.txt webapps/* 
cd conf
rm -rf  *.original  server.xml  tomee.xml  web.xml
cd ..
cd ..
cp conf/tomee/*.xml virtualskynet/conf/
cp conf/tomee/*.properties virtualskynet/conf/
cp conf/lib/*  virtualskynet/lib/
mv virtualskynet /root

echo -e "\e[1;31m  -  Installing VirtualSkynet InitScripts  -  \e[0m"
cp conf/tomee/virtualskynet  /etc/init.d/
chmod 777 /etc/init.d/virtualskynet
service virtualskynet start
chkconfig virtualskynet on

echo -e "\e[1;31m  -  VirtualSkynet Application Suite Install - Version 1.0  -  \e[0m"
echo -e "\e[1;31m  -  Installing Last Aplication Suite Version  -  \e[0m"
cp aplication/*.war  /root/virtualskynet/webapps/


echo -e "\033[33;31m --- Aplication Install ... Done! ---"
init 6


