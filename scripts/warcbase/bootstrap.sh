#!/bin/bash

# for vanilla Ubuntu 16

sudo apt-get -y update
sudo apt-get -y install htop
sudo apt-get -y install git
sudo apt-get -y install openjdk-8-jdk openjdk-8-jdk-headless openjdk-8-jre
sed -i '$iJAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' /etc/environment
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
sudo apt-get -y install maven
sudo apt-get -y install scala

wget http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz
tar -xvf spark-1.5.1-bin-hadoop2.6.tgz
rm spark-1.5.1-bin-hadoop2.6.tgz
cd --
git clone https://github.com/lintool/warcbase.git
cd warcbase
mvn clean package -pl warcbase-core -DskipTests
