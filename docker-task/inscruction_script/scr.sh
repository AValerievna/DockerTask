#!/bin/sh
sudo apt-get update
sudo apt-get install tomcat8
sudo service tomcat8 start


cd /ets/tomcat8 
sed -i -e 's/port=\"8080\"/port=\"8081\"/g' server.xmld

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

sudo apt-get update
sudo apt-get install erlang erlang-nox

echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -

sudo apt-get update
sudo apt-get install rabbitmq-server


cd /etc/rabbitmq
sudo sed -i -e 's/#NODE_PORT=5672/#NODE_PORT=8080/g' rabbitmq-env.conf

sudo rabbitmqctl add_user username password

cd /home/alexandra/Downloads/docker-test-task-master
mvn clean package


sudo cp /home/alexandra/Downloads/docker-test-task-master/target/docker-task-1.0.war /var/lib/tomcat8/webapps


cd /var/lib/tomcat8/conf
sudo sed -i -e 's/<\/tomcat-users>/	<role rolename="manager-gui"\/>	<user username="admin"	password="admin" roles="manager-gui"\/>	<\/tomcat-users>/g' tomcat-users.xml 
sudo service tomcat8 restart
xdg-open http://localhost:8081/manager/html



