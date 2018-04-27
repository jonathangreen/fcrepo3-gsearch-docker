#!/bin/bash

# Setup Tomcat7
rm $CATALINA_HOME/conf/logging.properties
rm $CATALINA_HOME/bin/tomcat-juli.jar
rm -Rf $CATALINA_HOME/webapps/*

wget -P $CATALINA_HOME/lib http://archive.apache.org/dist/logging/log4j/1.2.17/log4j-1.2.17.jar
wget -P $CATALINA_HOME/lib http://central.maven.org/maven2/log4j/apache-log4j-extras/1.1/apache-log4j-extras-1.1.jar
wget -P $CATALINA_HOME/lib http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli-adapters.jar
wget -P $CATALINA_HOME/bin http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli.jar

cp /build/tomcat/log4j.properties $CATALINA_HOME/lib/log4j.properties
cp /build/tomcat/server.xml $CATALINA_HOME/conf/server.xml
