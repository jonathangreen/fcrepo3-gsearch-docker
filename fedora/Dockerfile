FROM jonathangreen/fcrepo3-gsearch:base
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

COPY . /opt/fedora_docker

# Install some required packages
RUN apk add --no-cache \
    unzip \
    ca-certificates \
    openssl && \
    update-ca-certificates

# Install confd for templating our configuration
RUN mv /opt/fedora_docker/confd/templates/* /etc/confd/templates/; \
  mv /opt/fedora_docker/confd/conf.d/* /etc/confd/conf.d/; \
  chmod +x /opt/fedora_docker/start.sh

# Install Fedora Commons 3
RUN wget -P /opt/fedora_docker/ https://downloads.sourceforge.net/project/fedora-commons/fedora/3.8.1/fcrepo-installer-3.8.1.jar; \
  yes | java -jar /opt/fedora_docker/fcrepo-installer-3.8.1.jar /opt/fedora_docker/files/install.properties; \
  rm -Rf /opt/fedora/install; \
  rm -Rf /opt/fedora/docs; \
  rm /opt/fedora_docker/fcrepo-installer-3.8.1.jar; \
  unzip $CATALINA_HOME/webapps/fedora.war -d $CATALINA_HOME/webapps/fedora; \
  rm $CATALINA_HOME/webapps/fedora.war; \
  mv /opt/fedora_docker/files/logback.xml /opt/fedora/server/config/logback.xml; \
  mv /opt/fedora_docker/xacml /opt/fedora/xacml; \
  wget https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-3.8.1.jar -P $CATALINA_HOME/webapps/fedora/WEB-INF/lib/; \
  mv /opt/fedora_docker/files/jaas.conf /opt/fedora/server/config/jaas.conf

# Expose port 8080 and start tomcat
WORKDIR /opt/fedora_docker
EXPOSE 8080
CMD ["./start.sh"]
