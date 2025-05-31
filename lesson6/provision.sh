#!/bin/bash
ROLE=$1

if [ "$ROLE" == "server" ]; then
  mkdir -p /home/vagrant/.ssh
  chmod 700 /home/vagrant/.ssh
  cp /vagrant/ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
  chmod 600 /home/vagrant/.ssh/authorized_keys
  chown -R vagrant:vagrant /home/vagrant/.ssh

elif [ "$ROLE" == "client" ]; then
  mkdir -p /home/vagrant/.ssh
  cp /vagrant/ssh/id_rsa /home/vagrant/.ssh/id_rsa
  chmod 600 /home/vagrant/.ssh/id_rsa
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
fi
