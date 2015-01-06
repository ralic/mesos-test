#!/bin/sh

apt -y install mesos marathon chronos lxc-docker conntrack ethtool python-pip

echo "1" > /etc/zookeeper/conf/myid

echo "server.1=192.168.50.100:2888:3888" >> /etc/zookeeper/conf/zoo.cfg

service zookeeper restart

echo "zk://192.168.50.100:2181/mesos" > /etc/mesos/zk

echo "1" > /etc/mesos-master/quorum

service mesos-slave stop
echo manual >/etc/init/mesos-slave.override

echo "`hostname -i` `hostname`" >>/etc/hosts
echo "`hostname -i`" >/etc/mesos-master/hostname

service mesos-master restart
service marathon restart
service chronos restart


