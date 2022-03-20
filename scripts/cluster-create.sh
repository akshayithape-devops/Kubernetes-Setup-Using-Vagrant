#!/bin/bash

# Pull the require images
kubeadm config images pull

# Initializing your control-plane node
kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=$master_node_ip

# Export Kubernetes Cluster Token to an External File
kubeadm token create --print-join-command > /vagrant/scripts/join-token.sh
chmod +x /vagrant/scripts/join-token.sh