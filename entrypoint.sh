#!/bin/bash
# Copyright (C) 2015-2021, Wazuh Inc.
# Created by Wazuh, Inc. .
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2
#pip3 install docker
#echo "<ossec_config><wodle name=\"docker-listener\"><disabled>no</disabled></wodle></ossec_config>" >> /var/ossec/etc/ossec.conf
/var/ossec/bin/agent-auth -m ${WAZUH_MANAGER}
#sed -i 's/MANAGER_IP/192.168.32.128/g' /var/ossec/etc/ossec.conf
/var/ossec/bin/wazuh-control restart 
# Auto restart when agent is down
sleep  10
for (( ; ; )) 
do
  if pidof wazuh-logcollector > /dev/null
  then
    echo "Agent running"
  else
    echo "Restart wazuh-agent"
    /var/ossec/bin/wazuh-control restart
  fi
  sleep 10m
done
