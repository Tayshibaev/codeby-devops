#!/bin/bash
echo "192.168.56.11 example.local www.example.local" >> /etc/hosts

scp -o StrictHostKeyChecking=no -i /vagrant/.vagrant/machines/server/virtualbox/private_key \
  vagrant@192.168.56.11:/etc/apache2/ssl/example.local.crt /tmp/example.local.crt

apt-get update
apt-get install -y ca-certificates
cp /tmp/example.local.crt /usr/local/share/ca-certificates/example.local.crt
update-ca-certificates

apt-get install -y curl