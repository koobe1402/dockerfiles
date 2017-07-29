FROM centos:7.3.1611

ARG http_port=8080

RUN yum -y update \
  && yum clean all

RUN yum -y install wget \
                   java \
  && wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo \
  && rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key \
  && yum -y install jenkins

COPY include/run.sh /bin/run.sh
RUN chmod 700 /bin/run.sh

EXPOSE ${http_port}/tcp
CMD ["bin/run.sh"]
