# k8s_cluster_setup
## Setup of a small VM cluster so that k8s can be install from scratch
## Usage

First, clone this project `thisproject`:
The prerequisite is that you have 4 VMs preconfigure 1CPU and 1GB RAM and 10GB for storage.
In the future maybe I will automate these steps. For now, I am just adding a way to easily launch the vms at once.

1. master_node_00
2. slave_node_01
3. slave_node_02
4. slave_node_03

These VMs are all connected via an internal network k8s_internal on the second interface enp0s8. The command to create the internal is shown below.
In fact each VM contains two Network Interfaces:
1. Nat and seteup for SSH (to acces each node)
2. Internal Network to reach all the nodes
```bash
$ VBoxManage dhcpserver add --netname k8s_cluster --ip 10.10.10.1 --netmask 255.255.255.0 --lowerip 10.10.10.2 --upperip 10.10.10.12 --enable
```
```sh
$ git clone git@github.com:davidgarciaMontreal/k8s_cluster_setup.git
$ source k8s_cluster_setup/bash_src/bashrc.sh
```
If you want to launch all the vms at once:
```sh
$ launch_cluster up
```
If you want to turn off all the vms at once:
```sh
$ launch_cluster down
```
