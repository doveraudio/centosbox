#!/bin/bash
### Provision Vagrant ###
## Check for updates ##
cd /var/data;
curl 'https://setup.ius.io/' -o setup-ius.sh;
sudo sh setup-ius.sh;
printf "Checking for updates....\n";
sudo yum -y update;
#Installing development tools
printf "Installing development tools";
##sudo yum groups mark install "Development Tools";
##sudo yum -y group install "Development Tools";
##sudo yum groupinstall "Additional Development";
###sudo yum install -y openssl-devel mariadb-devel redis libselinux-python mysql-devel mysql-libs libXrender libXext xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 libjpeg-devel zlib-devel libzip-devel freetype-devel lcms2-devel libwebp-devel libtiff-devel tcl-devel tk-devel openldap-devel;
sudo yum install -y openssl-devel mysql-devel mysql-libs redis libselinux-python libXrender libXext xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 libjpeg-devel zlib-devel libzip-devel freetype-devel lcms2-devel libwebp-devel libtiff-devel tcl-devel tk-devel openldap-devel;
#check version installed
printf "Checking gcc version installed";
gcc --version;
sudo yum -y remove OpenJDK;

### Install wget
printf "Install wget...\n";

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
##sudo sh ./configure --prefix=/usr  --sysconfdir=/etc  --with-ssl=openssl
cd /var/build/wget-1.19.1/;

sudo make;

sudo make install;
##display wget version
printf "Completed Build and Install, checking installation..\n";
wget --version;

### Install unzip


printf "Install unzip...\n"
sudo yum -y install unzip;
## change to var/data folder
printf "Changing to /var/data/ \n";
cd /var/data;
### Download JAVA SDK 1.8
printf "Downloading Java SDK...\n";
#sudo wget --progress=dot:mega --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz";
sudo curl -L -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz -O

printf "Download Complete\n";
# create folder /usr/java/
printf "Creating folder /usr/java/\n";
sudo mkdir /usr/java;
# untar Java in /usr/java;
printf "Untar jdk-8u131-linux-x64 to /usr/java\n";
sudo tar -xzf /var/data/jdk-8u131-linux-x64.tar.gz -C /usr/java;
## change to var/data folder
printf "Changing to /var/data/ \n";
cd /var/data;
# copy java config file to /etc/profile.d/java_dev.sh
printf "Copying java config file to /etc/profile.d/java_dev.sh...\n";
sudo cp -v /var/data/java_dev.sh /etc/profile.d/java_dev.sh;
##create folder for ant
printf "Creating base folder for Apache Ant...\n(/usr/java/ant)...\n";
sudo mkdir /usr/java/ant;
##download apache ant
printf "Downloading Apache Ant...\n";
sudo curl -O "http://mirrors.koehn.com/apache//ant/binaries/apache-ant-1.10.1-bin.tar.gz";
printf "Download Complete\n";
##Unpack to /usr/java/ant
printf "Unpacking Apache Ant to folder: /usr/java/ant";
sudo tar -xzf /var/data/apache-ant-1.10.1-bin.tar.gz -C /usr/java/ant;
##copy ant config file to /etc/profile.d/ant_env.sh
sudo cp -v /var/data/ant_env.sh /etc/profile.d/ant_env.sh;
##create folder for maven
printf "Creating base folder for Apache Maven...\n";
sudo mkdir /usr/java/maven;
## Download Apache Maven
printf "Downloading Apache Maven...\n";
sudo curl -O "http://apache.osuosl.org/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz";
printf "Download Complete\n";
## Unpack to /usr/java/maven
printf "Unpacking Apache Maven to folder: /usr/java/maven";
sudo tar -xzf /var/data/apache-maven-3.5.0-bin.tar.gz -C /usr/java/maven;
## Copy Maven config file to /etc/profile.d/maven_env.sh
sudo cp -v /var/data/maven_env.sh /etc/profile.d/maven_env.sh;
## Set up config files for this session, they will be set with each reboot.
printf "Setting java environment profiles for this session, will be run from now on each reboot.\n";
source /etc/profile;
printf "Final Java Settings:\n";
printf $JAVA_HOME"\n";
printf $ANT_HOME"\n";
printf $MAVEN_HOME"\n";
printf $PATH"\n";
printf "\n Listing Binaries,\n Stand By...\n";
java -version;
printf "\n";
ant -version;
printf "\n";
mvn -version;
printf "\n";
##install POSTGRES
printf "Installing Postgresql....";
sudo rpm -iUvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm;
sudo yum -y update;
sudo yum -y install postgresql96 postgresql96-server postgresql96-contrib postgresql96-libs;

sudo systemctl enable postgresql-9.6;
cd /usr/pgsql-9.6/bin/;
sudo ./postgresql96-setup initdb;
sudo systemctl start postgresql-9.6;
printf "Postgresql setup complete";
cd /var/data;
printf "Provisioning Script Complete\n\n";


