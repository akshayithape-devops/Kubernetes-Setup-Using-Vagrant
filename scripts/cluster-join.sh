#!/bin/bash

# Join Kubernetes Cluster
/vagrant/scripts/join-token.sh

echo "Environment='KUBELET_EXTRA_ARGS=--node-ip=$master_node_ip'" | tee -a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet