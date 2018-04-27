#!/bin/bash

wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64
chmod +x /usr/local/bin/confd
mkdir /etc/confd
mkdir /etc/confd/conf.d
mkdir /etc/confd/templates
