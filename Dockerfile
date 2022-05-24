FROM python:3.9.13-slim-bullseye
# Dependencies
RUN apt-get update && \
    apt-get install curl procps apt-transport-https lsb-release -y &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    mkdir /scripts /config\
    pip3 install docker
# Install the Wazuh agent
ARG MANAGER_IP="192.168.32.128"
ENV WAZUH_MANAGER ${MANAGER_IP}
RUN curl -so wazuh-agent.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.3.0-1_amd64.deb && WAZUH_MANAGER=${WAZUH_MANAGER} dpkg -i ./wazuh-agent.deb

RUN echo "<ossec_config><wodle name=\"docker-listener\"><disabled>no</disabled><run_on_start>yes</run_on_start></wodle></ossec_config>" >> /var/ossec/etc/ossec.conf
# Entrypoint
RUN export WAZUH_MANAGER="${WAZUH_MANAGER}"
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
