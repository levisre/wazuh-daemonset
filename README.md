# wazuh-daemonset
Run Wazuh agent in Daemon Set to monitor Kubernetes Nodes

## How to use

1. Clone this repository
2. Use `build.sh` with 1st param is the Wazuh Manager' IP: for e,g `./build.sh 192.168.1.10`. Then wait for the image being built by docker.
3. `kubectl apply -f daemonset.yaml` to deploy to your k8s cluster.
