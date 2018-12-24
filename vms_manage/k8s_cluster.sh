#!/usr/bin/env bash
# TODO: create clusters via cli command line
k8s::create_internal_network () {
    # VBoxManage dhcpserver add --netname k8s_cluster --ip 10.10.10.1 --netmask 255.255.255.0 --lowerip 10.10.10.2 --upperip 10.10.10.12 --enable
    :
}

k8s::setup_vms () {
    # TODO: Option use pre-made vm and clone
    # TODO: used https://www.ubuntu.com/download/server Ubuntu Server 18.04.1 LTS
    # TODO: create user: kube/kube
    # TODO: use two Network Adapters
    # TODO: Adapter1: attached to NAT : Port Forwarding SSH TCP Host Port 14501 ..1450X
    # TODO: Adapter2: attached to Internal Network k8s_cluster
    :
}

k8s::create_vms () {
    :
}
# launch_cluster up first
ssh -p 14501 kube@127.0.0.1
ssh -p 14502 kube@127.0.0.1
ssh -p 14503 kube@127.0.0.1
ssh -p 14504 kube@127.0.0.1
