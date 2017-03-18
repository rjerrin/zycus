#pull centos image

FROM centos:centos6

#add mongodb repo
ADD ./mongodb.repo  /etc/yum.repos.d/mongodb.repo

#Add repository for python-2.7

#update yum repository and clean cache
RUN yum -y update
#install packages
RUN yum install -y centos-release-scl
RUN yum install  -y  python27  mongo-10gen mongo-10gen-server python-setuptools
RUN easy_install supervisor

#install wget and tar 
RUN yum install -y wget tar


#Prepare environment for java and tomcat 

ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat 
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts
ENV JAVA_VERSION 8u112 
ENV JAVA_BUILD 8u112-b15
ENV TOMCAT_VERSION  7.0.76

RUN wget --no-check-certificate --no-cookies --header "Cookie:oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/jdk-${JAVA_VERSION}-linux-x64.tar.gz
RUN  tar -xvf jdk-${JAVA_VERSION}-linux-x64.tar.gz 
RUN  rm jdk*.tar.gz
RUN  mv jdk* ${JAVA_HOME}




RUN  wget http://mirror.fibergrid.in/apache/tomcat/tomcat-7/v7.0.76/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz 
RUN  tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz 
RUN  rm apache-tomcat*.tar.gz 
RUN mv apache-tomcat* ${CATALINA_HOME}

RUN chmod +x ${CATALINA_HOME}/bin/*sh

# Add tomcat.sh script and change port to 7090
ADD tomcat.sh $CATALINA_HOME/scripts/tomcat.sh
RUN chmod +x $CATALINA_HOME/scripts/*.sh


#create user for running tomcat 

RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

#add supervisord.conf for running tomcat and mongodb
ADD supervisord.conf /etc/


#Expose ports for tomcat and mongo

EXPOSE  7080
EXPOSE  27017

#Run supervisord to start tomcat and mongodb

CMD   ["supervisord", "-n"]


