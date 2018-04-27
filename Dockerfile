FROM tomcat:7-jre8-alpine
MAINTAINER Jonathan Green <jonathan@razzard.com>

ENV JAVA_OPTS="-Xms2g -Xmx2g -XX:NewSize=256m -XX:MaxNewSize=356m -Djavax.net.ssl.trustStore=/opt/fedora/truststore -Djavax.net.ssl.trustStorePassword=tomcat" \
    CATALINA_TMPDIR=/tmp \
    FEDORA_HOME=/opt/fedora \
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
    FEDORA_DRUPAL_DB_PORT=3306 \
    FEDORA_SOLR_URL=http://localhost:8080/solr/update

COPY . /build

RUN /build/scripts/tomcat.sh
RUN /build/scripts/confd.sh
RUN /build/scripts/fedora.sh
RUN /build/scripts/gsearch.sh

# Expose port 8080 and start tomcat
WORKDIR /build/scripts
EXPOSE 8080
CMD ["./start.sh"]
