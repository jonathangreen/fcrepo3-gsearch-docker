#!/bin/bash

# Setup confd templates
mv /build/gsearch/confd/conf.d/* /etc/confd/conf.d/
mv /build/gsearch/confd/templates/* /etc/confd/templates/

# Install GSearch
wget https://github.com/discoverygarden/gsearch/releases/download/v2.8.1/fedoragsearch.war -P $CATALINA_HOME/webapps
unzip $CATALINA_HOME/webapps/fedoragsearch.war -d $CATALINA_HOME/webapps/fedoragsearch
rm $CATALINA_HOME/webapps/fedoragsearch.war

rm $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/lib/log4j-1.2.15.jar
mv /build/gsearch/files/log4j.properties $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/classes/log4j.properties
wget http://archive.apache.org/dist/logging/log4j/1.2.17/log4j-1.2.17.jar -P $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/lib
wget http://central.maven.org/maven2/log4j/apache-log4j-extras/1.1/apache-log4j-extras-1.1.jar -P $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/lib

rm -Rf $CATALINA_HOME/webapps/fedoragsearch/FgsConfig
rm -Rf $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/classes/configDemoIndexPerDS_fgs24_1019
rm -Rf $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/classes/configDemoOnSolr
rm -Rf $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/classes/configDemoSearchResultFiltering

wget https://github.com/discoverygarden/dgi_gsearch_extensions/releases/download/v0.1.3/gsearch_extensions-0.1.3-jar-with-dependencies.jar -P $CATALINA_HOME/webapps/fedoragsearch/WEB-INF/lib
