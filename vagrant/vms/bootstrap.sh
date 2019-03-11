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
sudo groupadd docker || true
sudo usermod -aG docker vagrant || true
sudo setenforce 0
sudo systemctl disable firewalld && sudo systemctl stop firewalld
sudo service docker restart
eth1_ip=$(cat /etc/sysconfig/network-scripts/ifcfg-eth1 | grep IPADDR | awk -F"=" '{print $2}')
echo "KUBELET_EXTRA_ARGS=--node-ip=${eth1_ip}"  > /tmp/conf
sudo cp /tmp/conf /etc/sysconfig/kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
host_name=$(hostname)
if [[ ${host_name} == "master" ]];then
    echo "on master"
    pushd /home/vagrant/k8s_setup &> /dev/null
    chmod 777 ./centos7/setup.sh
    su vagrant -c './centos7/setup.sh'

else
    echo "on worker"
fi