#! /bin/bash
ASTERISK=http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11-current.tar.gz
PASSWORD=p4ssw0rd

echo -e ""
echo -e "\e[1;31m  -  VirtualSkynet CentOS AutoInstall Script  -  \e[0m"
echo -e ""

echo -e "\e[1;31m  -  Disable Selinux Runtime  -  \e[0m"
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

echo -e "\e[1;31m  -  Installing VSN Asterisk Realtime Packages  -  \e[0m"
yum -y install unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel  mysql-connector-odbc mysql mysql-devel  postgresql-odbc postgresql postgresql-devel

echo -e "\e[1;31m  -  Setting Up ODBC Realtime  -  \e[0m"
echo "[mysql]" >> /etc/odbc.ini
echo "Description = MySQL Asterisk database" >> /etc/odbc.ini
echo "Trace = Off" >> /etc/odbc.ini
echo "TraceFile = stderr" >> /etc/odbc.ini
echo "Driver = MySQL" >> /etc/odbc.ini
echo "SERVER = 127.0.0.1" >> /etc/odbc.ini
echo "USER = root" >> /etc/odbc.ini
echo "PASSWORD = ${PASSWORD}" >> /etc/odbc.ini
echo "PORT = 3306" >> /etc/odbc.ini
echo "DATABASE = virtualskynet" >> /etc/odbc.ini


echo -e "\e[1;31m  -  Installing VSN Asterisk Packages  -  \e[0m"
yum -y install  make  gcc  gcc-c++  openssl-devel libtermcap-devel libxml2-devel sqlite sqlite-devel
rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
yum -y install sox mpg123 lame


echo -e "\e[1;31m  -  Installing Linux Packages  -  \e[0m"
yum -y install htop sendmail* vim-enhanced wget
chkconfig sendmail on

echo -e "\e[1;31m  -  Installing Asterisk Core  -  \e[0m"
wget ${ASTERISK}
tar xfz asterisk-*
rm -rf *.tar.gz
cd asterisk*
./configure
make && make install && make config
service asterisk start
chkconfig asterisk on
cd ..
rm -rf asterisk*

echo -e "\e[1;31m  -  Installing VSN WebServer  -  \e[0m"
yum -y install httpd

echo -e "\e[1;31m  -  Setting Asterisk Configuration  -  \e[0m"
cp -rf conf/asterisk/* /etc/asterisk/

echo -e "\e[1;31m  -  Updating Dependencies  -  \e[0m"
ldconfig


echo -e "\033[33;31m --- Aplication Install ... Done! ---"
init 6



