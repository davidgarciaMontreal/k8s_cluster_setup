#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
eth1_ip=$(cat /etc/sysconfig/network-scripts/ifcfg-eth1 | grep IPADDR | awk -F"=" '{print $2}')
sudo kubeadm init --apiserver-advertise-address ${eth1_ip} --pod-network-cidr 10.244.0.0/16
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f kube-flannel.yml