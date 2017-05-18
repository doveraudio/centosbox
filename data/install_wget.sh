#!/bin/bash
cd /var/;
sudo mkdir build;
cd /var/build;
sudo curl http://ftp.gnu.org/gnu/wget/wget-1.19.1.tar.gz -O;
sudo yum -y remove wget;
sudo tar -xzvf wget-1.19.1.tar.gz;
chmod 777 -R /var/build/;
cd /var/build/wget-1.19.1/;
sudo sh ./configure --with-ssl=openssl --with-libssl-prefix=/usr/lib64/openssl --prefix=/usr;
##sudo . sh ./configure --prefix=/usr  --sysconfdir=/etc  --with-ssl=openssl;
sudo sh ./configure --prefix=/usr  --sysconfdir=/etc  --with-ssl=openssl
sudo /var/build/wget-1.19.1/make;

sudo /var/build/wget-1.19.1/make install;