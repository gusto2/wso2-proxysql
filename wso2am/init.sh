#!/bin/bash

if [ ! -d "${CARBON_HOME}/repository/deployment/server/synapse-configs/default" ]; then
  echo "empty ${CARBON_HOME}/repository/deployment/server/synapse-configs/default, copying"
  cp -rL /tmp/server/synapse-configs/* ${CARBON_HOME}/repository/deployment/server/synapse-configs/
fi

if [ -d "/home/wso2carbon/wso2-conf-volume" ]; then
 echo "wso2-conf-volume found, copying configuration"
 cp -rL /home/wso2carbon/wso2-conf-volume/* ${CARBON_HOME}
else
 echo "wso2-conf-volume not found"
fi

if [ -d "/home/wso2carbon/wso2-artifact-volume" ]; then
 echo "wso2-conf-volume found, copying configuration"
 cp -rL /home/wso2carbon/wso2-artifact-volume/* ${CARBON_HOME}
else
 echo "wso2-artifact-volume not found"
fi

mkdir -p /home/wso2carbon/.java/.systemPrefs

if [ -z "${JAVA_OPTS}"]; then
  echo "setting JAVA_OPTS=-Djava.util.prefs.userRoot=/home/wso2carbon/ -Djava.util.prefs.systemRoot=/home/wso2carbon/.java/"
  export JAVA_OPTS="-Djava.util.prefs.userRoot=/home/wso2carbon/ -Djava.util.prefs.systemRoot=/home/wso2carbon/.java/"
fi

if [ -n "${CARBON_PASSWORD}" ]; then
  echo -n "${CARBON_PASSWORD}" > ${CARBON_HOME}/password-tmp ;
else
  echo "CARBON_PASSWORD not present";
fi

# for example, set the Docker container IP as the `localMemberHost` under axis2.xml clustering configurations (effective only when clustering is enabled)
docker_container_ip="${MY_POD_IP}"
if [ -n "${docker_container_ip}" ]; then
 # capture Docker container IP from the container's /etc/hosts file
 docker_container_ip=$(awk 'END{print $1}' /etc/hosts)
fi
sed -i "s#<parameter\ name=\"localMemberHost\".*<\/parameter>#<parameter\ name=\"localMemberHost\">${docker_container_ip}<\/parameter>#" ${CARBON_HOME}/repository/conf/axis2/axis2.xml


sh ${CARBON_HOME}/bin/wso2server.sh $*


