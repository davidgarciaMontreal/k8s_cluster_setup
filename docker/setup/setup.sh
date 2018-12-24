#!/usr/bin/env bash
# SEE https://docs.docker.com/config/daemon/systemd/
# SEE https://docs.docker.com/install/linux/docker-ce/binaries/#install-static-binaries
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
codename=$(lsb_release -c | awk -F" " '{print $2}')
[[ $codename != bionic ]] && echo "Only supports Release 18.04" && exit 1

dir=/tmp/t
docker_version=docker-18.09.0.tgz
mkdir -p $dir
pushd $dir
wget https://download.docker.com/linux/static/stable/x86_64/$docker_version
tar -zxvf $docker_version
cp docker/* /usr/bin/
rm -rf $docker_version
popd
_this=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
user=kube
cp -f ${_this}/docker.service /etc/systemd/system/
addgroup --system docker
adduser $user docker
newgrp docker
systemctl daemon-reload
systemctl start docker
systemctl enable docker