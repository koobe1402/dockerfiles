#!/bin/bash

export JENKINS_HOME='/var/lib/jenkins'
export FILE='jenkins.install.InstallUtil.lastExecVersion'

if ! [ -f $JENKINS_HOME/$FILE ]; then
  echo "2.0" > "${JENKINS_HOME}"/$FILE
fi

/usr/bin/java -Djava.awt.headless=true -jar /usr/lib/jenkins/jenkins.war
