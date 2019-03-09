#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

sudo kubeadm reset --force
rm -rf ~/.kube
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
eth1_ip=$(cat /etc/sysconfig/network-scripts/ifcfg-eth1 | grep IPADDR | awk -F"=" '{print $2}')
sudo kubeadm init --apiserver-advertise-address ${eth1_ip} --pod-network-cidr 10.244.0.0/16 &> ~/current_config.log
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f ${DIR}/kube-flannel.yml &> /dev/null
# TODO: run join on worker nodes
sudo cp /tmp/proxy.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl disable proxy.service
sudo systemctl enable proxy.service
sudo systemctl stop  proxy.service
sudo systemctl start proxy.service
sudo systemctl status  proxy.service
sudo rm -rf /tmp/proxy.service
kubectl create -f ${DIR}/kubernetes-dashboard.yaml
kubectl apply -f  ${DIR}/dashboard-adminuser.yaml
kubectl apply -f  ${DIR}/ClusterRoleBinding.yaml
grep 'kubeadm join' ~/current_config.log
kubectl get all