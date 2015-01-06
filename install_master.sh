#!/bin/sh

bash /vagrant/repo.sh

apt -y install mesos marathon chronos lxc-docker conntrack ethtool python-pip

echo "1" > /etc/zookeeper/conf/myid

echo "server.1=192.168.50.100:2888:3888" >> /etc/zookeeper/conf/zoo.cfg

service zookeeper restart

echo "zk://192.168.50.100:2181/mesos" > /etc/mesos/zk

echo "1" > /etc/mesos-master/quorum

service mesos-slave stop
echo manual >/etc/init/mesos-slave.override

sed -i '/slave/d' /etc/hosts
sed -i '/master/d' /etc/hosts
echo "192.168.50.100 master" >>/etc/hosts
echo "192.168.50.100" >/etc/mesos-master/hostname

service mesos-master restart
service marathon restart
service chronos restart

cd /root
git clone https://github.com/mesosphere/marathon.git
cd marathon/bin
./haproxy-marathon-bridge install_haproxy_system localhost:8080


