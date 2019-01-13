#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
rm -rf /etc/yum.repos.d/kubernetes.repo || true
sudo cp /tmp/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
sudo systemctl restart sshd
sudo yum install -y docker kubelet kubeadm kubectl kubernetes-cni
sudo systemctl enable docker && systemctl start docker
sudo systemctl enable kubelet && systemctl start kubelet
sudo groupadd docker
sudo usermod -aG docker vagrant