#!/bin/bash

apt -y install mesos lxc-docker conntrack ethtool

service zookeeper stop
echo manual > /etc/init/zookeeper.override

echo "zk://192.168.50.100:2181/mesos" > /etc/mesos/zk

service mesos-master stop
echo manual > /etc/init/mesos-master.override

sed -i '/slave/d' /etc/hosts
h=`hostname`
myip=192.168.50.1`echo "${h: -1}"`
echo "${myip} `hostname`" >>/etc/hosts
echo "${myip}" >/etc/mesos-slave/hostname
echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
echo "cpus(*):2; mem(*):1536; disk(*):20000; ports(*):[31000-32000]" > /etc/mesos-slave/resources
