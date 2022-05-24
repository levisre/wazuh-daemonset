#!/bin/sh

docker build . -t wazuh-daemonset:0.1 --build-arg MANAGER_IP=$1
