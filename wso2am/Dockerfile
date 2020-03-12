FROM openjdk:8

Maintainer Gabriel

RUN  addgroup --gid 802 wso2 \
  && adduser  --gid 802 --uid 802 --disabled-password wso2carbon

ARG WSO2_SERVER_HOME=/home/wso2carbon/wso2am-2.6.0

COPY --chown=802:802 wso2am-2.6.0 ${WSO2_SERVER_HOME}
COPY init.sh /home/wso2carbon/
COPY mysql-connector-java-8.0.11.jar ${WSO2_SERVER_HOME}/repository/components/lib

RUN chmod +x /home/wso2carbon/init.sh \
 && cp -RL /home/wso2carbon/wso2am-2.6.0/repository/deployment/server /tmp

ENV CARBON_HOME=${WSO2_SERVER_HOME}

# COPY files/mysql-connector-java-*.jar ${WSO2_SERVER_HOME}/lib
# COPY files/mysql-connector-java-*.jar ${WSO2_SERVER_HOME}/wso2/lib
# # add libraries for Kubernetes membership scheme based clustering
# ADD files/dnsjava-2.1.8.jar ${WSO2_SERVER_HOME}/lib
# ADD files/kubernetes-membership-scheme-1.0.5.jar ${WSO2_SERVER_HOME}/dropins
# # add jolokia jmx agent for monitoring
# ADD files/jolokia-osgi-1.6.1.jar ${WSO2_SERVER_HOME}/dropins
# # copy keystores
# ADD files/fileconnector-connector-2.0.11.zip ${WSO2_SERVER_HOME}/repository/deployment/server/synapse-libs/


VOLUME /home/wso2carbon/wso2-artifact-volume \
       /home/wso2carbon/wso2-conf-volume \
       /home/wso2carbon/wso2am-2.6.0/deployment/server/carbonapps

WORKDIR /home/wso2carbon
USER wso2carbon

CMD ["/home/wso2carbon/init.sh", "$*"]

