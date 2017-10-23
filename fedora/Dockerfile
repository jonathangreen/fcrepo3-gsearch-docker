FROM lyrasis-fedora:base
MAINTAINER Jonathan Green <jonathan@razzard.com>

ENV FEDORA_HOME=/opt/fedora \
    FEDORA_ADMIN_PASSWORD=fedoraAdmin \
    FEDORA_SERVER_HOST=localhost \
    FEDORA_DB_TYPE=derby \
    FEDORA_DEFAULT_NAMESPACE=default \
    FEDORA_JMS_BROKER="vm:(broker:(tcp://localhost:61616))" \
    FEDORA_DB_USER=fedora \
    FEDORA_DB_PASSWORD=fedora \
    FEDORA_DB_HOST=localhost \
    FEDORA_DB_NAME=fedora3 \
    FEDORA_DRUPAL_DB_SERVER=localhost \
    FEDORA_DRUPAL_DB_NAME=drupal \
    FEDORA_DRUPAL_DB_USER=drupal \
    FEDORA_DRUPAL_DB_PASSWORD=drupal \
    FEDORA_DRUPAL_DB_PORT=3306

COPY . /opt

RUN chown -R tomcat7:tomcat7 /opt; \ 
  apt-get update; \
  apt-get install -y --no-install-recommends unzip; \
  rm -rf /var/lib/apt/lists/*; \
  mv /opt/confd /etc/confd; \
  chmod +x /opt/start.sh

USER tomcat7:tomcat7

# Install Fedora Commons 3
RUN wget --no-check-certificate -P /opt http://downloads.sourceforge.net/fedora-commons/fcrepo-installer-3.8.1.jar;\
  yes | java -jar /opt/fcrepo-installer-3.8.1.jar /opt/files/install.properties; \
  rm -Rf /opt/fedora/install; \
  rm /opt/fcrepo-installer-3.8.1.jar; \
  unzip /var/lib/tomcat7/webapps/fedora.war -d /var/lib/tomcat7/webapps/fedora; \
  rm /var/lib/tomcat7/webapps/fedora.war; \
  mv /opt/files/logback.xml /opt/fedora/server/config/logback.xml; \
  mv /opt/xacml /opt/fedora/xacml; \
  wget --no-check-certificate -P /var/lib/tomcat7/webapps/fedora/WEB-INF/lib/ https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-3.8.1.jar; \
  mv /opt/files/jaas.conf /opt/fedora/server/config/jaas.conf

WORKDIR /opt
EXPOSE 8080
CMD ["./start.sh"]
