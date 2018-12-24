#!/usr/bin/env bash
# SEE https://docs.docker.com/config/daemon/systemd/
# SEE https://docs.docker.com/install/linux/docker-ce/binaries/#install-static-binaries
_this=$(readlink -f "${BASH_SOURCE[0]}")
codename=$(lsb_release -c | awk -F" " '{print $2}')
[[ $codename != bionic ]] && echo "Only supports Release 18.04" && exit 1
user=kube
cp -f ${_this}/docker.service /etc/systemd/system/
addgroup --system docker
adduser $kube docker
newgrp docker
systemctl daemon-reload
systemctl start docker
systemctl enable docker