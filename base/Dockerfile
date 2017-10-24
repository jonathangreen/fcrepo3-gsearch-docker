FROM tomcat:7-jre8-alpine
MAINTAINER Jonathan Green <jonathan@razzard.com>

ENV JAVA_OPTS="-Xms2g -Xmx2g -XX:NewSize=256m -XX:MaxNewSize=356m -Djavax.net.ssl.trustStore=/opt/fedora/truststore -Djavax.net.ssl.trustStorePassword=tomcat" \
    CATALINA_TMPDIR=/tmp

# Setup Tomcat7
RUN rm $CATALINA_HOME/conf/logging.properties; \
  rm $CATALINA_HOME/bin/tomcat-juli.jar; \
  rm -Rf $CATALINA_HOME/webapps/*; \
  wget -P $CATALINA_HOME/lib http://archive.apache.org/dist/logging/log4j/1.2.17/log4j-1.2.17.jar; \
  wget -P $CATALINA_HOME/lib http://central.maven.org/maven2/log4j/apache-log4j-extras/1.1/apache-log4j-extras-1.1.jar; \
  wget -P $CATALINA_HOME/lib http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli-adapters.jar; \
  wget -P $CATALINA_HOME/bin http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli.jar
COPY log4j.properties $CATALINA_HOME/lib/log4j.properties
COPY server.xml $CATALINA_HOME/conf/server.xml

# Setup confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd; \
  mkdir /etc/confd; \
  mkdir /etc/confd/conf.d; \
  mkdir /etc/confd/templates
