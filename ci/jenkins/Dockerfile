FROM centos:7.3.1611

ARG http_port=8080
ARG JENKINS_HOME='/var/lib/jenkins'

RUN yum -y update \
  && yum clean all

RUN yum -y install wget \
                   java \
  && wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo \
  && rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key \
  && yum -y install jenkins

COPY include/run.sh /bin/run.sh
RUN chmod 700 /bin/run.sh

RUN mkdir ${JENKINS_HOME}/init.groovy.d
COPY include/plugins.groovy ${JENKINS_HOME}/init.groovy.d/

COPY include/plugins_to_install ${JENKINS_HOME}/plugins_to_install

EXPOSE ${http_port}/tcp
CMD ["bin/run.sh"]
