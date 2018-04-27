#!/bin/bash

# Install some required packages
apk add --no-cache unzip
apk add --no-cache ca-certificates
apk add --no-cache openssl
update-ca-certificates

# Install confd for templating our configuration
cp /build/fedora/confd/templates/* /etc/confd/templates/
cp /build/fedora/confd/conf.d/* /etc/confd/conf.d/

# Install Fedora Commons 3
wget -P /build https://downloads.sourceforge.net/project/fedora-commons/fedora/3.8.1/fcrepo-installer-3.8.1.jar
java -jar /build/fcrepo-installer-3.8.1.jar /build/fedora/install.properties
rm -Rf /opt/fedora/install
rm -Rf /opt/fedora/docs
rm /build/fcrepo-installer-3.8.1.jar

unzip $CATALINA_HOME/webapps/fedora.war -d $CATALINA_HOME/webapps/fedora
rm $CATALINA_HOME/webapps/fedora.war
mv /build/fedora/logback.xml /opt/fedora/server/config/logback.xml
mv /build/fedora/xacml /opt/fedora/xacml

wget https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-3.8.1.jar \
  -P $CATALINA_HOME/webapps/fedora/WEB-INF/lib/
mv /build/fedora/jaas.conf /opt/fedora/server/config/jaas.conf
