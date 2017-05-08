FROM tomcat:9-alpine
MAINTAINER Jan Váňa

RUN apk update
RUN apk add ca-certificates
RUN update-ca-certificates
RUN apk add openssl

RUN mkdir ../resources

RUN wget -O ../resources/odalic.war https://github.com/odalic/sti/releases/download/v1.0.0/odalic-1.0.0.war
RUN mv -v ../resources/odalic.war webapps/odalic.war

RUN wget -O ../resources/docalic-ui.tar.gz https://github.com/odalic/odalic-ui/archive/v1.0.0.tar.gz
RUN tar -zxvf ../resources/docalic-ui.tar.gz -C ../resources
RUN mv ../resources/odalic-ui-1.0.0 webapps/odalic-ui

RUN wget -O ../resources/resources.tar.gz https://github.com/odalic/odalic-docker-repository/archive/1.0.8.tar.gz
RUN tar -zxvf ../resources/resources.tar.gz -C ../resources
RUN mv ../resources/odalic-docker-repository-1.0.8/configuration/tomcat/setenv.sh bin/setenv.sh
RUN rm conf/context.xml
RUN mv ../resources/odalic-docker-repository-1.0.8/configuration/tomcat/context.xml conf/context.xml
RUN rm conf/catalina.properties
RUN mv ../resources/odalic-docker-repository-1.0.8/configuration/tomcat/catalina.properties conf/catalina.properties
RUN chmod 750 bin/setenv.sh
RUN mv ../resources/odalic-docker-repository-1.0.8/configuration/odalic conf/odalic
RUN mkdir /usr/local/odalic
RUN mv ../resources/odalic-docker-repository-1.0.8/resources /usr/local/odalic/resources

RUN rm -rf ../resources
