FROM ubuntu:xenial
MAINTAINER Jonathan Green <jonathan@razzard.com>

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    JAVA_OPTS="-Xms2g -Xmx2g -XX:NewSize=256m -XX:MaxNewSize=356m -Djavax.net.ssl.trustStore=/opt/fedora/truststore -Djavax.net.ssl.trustStorePassword=tomcat" \
    CATALINA_HOME=/usr/share/tomcat7 \
    CATALINA_BASE=/var/lib/tomcat7 \
    CATALINA_TMPDIR=/tmp \
    TOMCAT7_SECURITY=no

# Install Oracle's JDK
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections; \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java.list; \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886; \
  apt-get update; \
  apt-get install -y --no-install-recommends oracle-java8-installer; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/cache/oracle-jdk8-installer

# Install Tomcat7
RUN apt-get update; \
  apt-get install -y --no-install-recommends tomcat7; \
  rm -rf /var/lib/apt/lists/*; \
  rm /etc/tomcat7/logging.properties; \
  rm /etc/cron.daily/tomcat7; \
  wget -P /usr/share/tomcat7/lib http://archive.apache.org/dist/logging/log4j/1.2.17/log4j-1.2.17.jar; \
  wget -P /usr/share/tomcat7/lib http://central.maven.org/maven2/log4j/apache-log4j-extras/1.1/apache-log4j-extras-1.1.jar; \
  wget -P /usr/share/tomcat7/lib http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli-adapters.jar; \
  rm /usr/share/tomcat7/bin/tomcat-juli.jar; \
  wget -P /usr/share/tomcat7/bin http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/extras/tomcat-juli.jar
COPY log4j.properties /usr/share/tomcat7/lib/log4j.properties
COPY server.xml /var/lib/tomcat7/conf/server.xml

# Setup confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
