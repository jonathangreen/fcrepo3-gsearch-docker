FROM lyrasis-fedora:fedora
MAINTAINER Jonathan Green <jonathan@razzard.com>

COPY . /opt/gsearch_docker

ENV FEDORA_SOLR_URL=http://localhost:8080/solr/update

USER root:root
RUN mv /opt/gsearch_docker/confd/conf.d/* /etc/confd/conf.d/; \
  mv /opt/gsearch_docker/confd/templates/* /etc/confd/templates/; \
  mv /opt/gsearch_docker/files/fedoragsearch.xml /etc/tomcat7/Catalina/localhost/fedoragsearch.xml; \
  chown -R tomcat7:tomcat7 /opt/gsearch_docker

USER tomcat7:tomcat7

# Install GSearch
RUN wget --no-check-certificate -P /var/lib/tomcat7/webapps https://github.com/discoverygarden/gsearch/releases/download/v2.8.1/fedoragsearch.war; \
  unzip /var/lib/tomcat7/webapps/fedoragsearch.war -d /var/lib/tomcat7/webapps/fedoragsearch; \
  rm /var/lib/tomcat7/webapps/fedoragsearch.war; \
  mkdir /opt/gsearch_docker/extensions; \
  rm /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/lib/log4j-1.2.15.jar; \
  wget --no-check-certificate -P /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/lib http://archive.apache.org/dist/logging/log4j/1.2.17/log4j-1.2.17.jar; \
  wget --no-check-certificate -P /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/lib http://central.maven.org/maven2/log4j/apache-log4j-extras/1.1/apache-log4j-extras-1.1.jar; \
  mv /opt/gsearch_docker/files/log4j.properties /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/log4j.properties; \
  wget --no-check-certificate -P /opt/gsearch_docker/extensions https://github.com/discoverygarden/dgi_gsearch_extensions/releases/download/v0.1.3/gsearch_extensions-0.1.3-jar-with-dependencies.jar; \
  rm -Rf /var/lib/tomcat7/webapps/fedoragsearch/FgsConfig; \
  rm -Rf /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/configDemoIndexPerDS_fgs24_1019; \
  rm -Rf /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/configDemoOnSolr; \
  rm -Rf /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/configDemoSearchResultFiltering; \
  mv /opt/gsearch_docker/files/fgsconfigFinal /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/
