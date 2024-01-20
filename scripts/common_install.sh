#!/bin/bash

# Update the system
apt-get update -y

# Upgrade the system
apt-get upgrade -y

# Install common require packages
apt-get install -y curl wget git unzip net-tools

# Disable the Swap Area
swapoff -a
sed -i '/swap/d' /etc/fstab

# Letting iptables see bridged traffic on Both Master and Clients
modprobe br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

# Require for CRI-O configuration
echo 1 > /proc/sys/net/ipv4/ip_forward

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

sudo systemctl stop ufw && sudo systemctl disable ufw
