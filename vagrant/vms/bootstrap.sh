#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
rm -rf /etc/yum.repos.d/kubernetes.repo || true
sudo cp /tmp/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
sudo cp /tmp/config /etc/selinux/config
sudo systemctl restart sshd
sudo yum install -y docker kubelet kubeadm kubectl kubernetes-cni
sudo systemctl enable docker && sudo systemctl start docker
sudo systemctl enable kubelet && sudo systemctl start kubelet
sudo sysctl -w net.bridge.bridge-nf-call-iptables=1
sudo echo "net.bridge.bridge-nf-call-iptables=1" > /etc/sysctl.d/k8s.conf
sudo swapoff -a && sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo setenforce 0
sudo systemctl disable firewalld && sudo systemctl stop firewalld