#!/usr/bin/env bash
realpath() {
    [[ $1 = /* ]] && echo \'"$1"\' || echo \'"$PWD/${1#./}"\'
}
_this=$(realpath "${BASH_SOURCE[0]}")
export k8s_this=$(dirname "${_this}")

k8s::up () {
    local p=$1
    ${p} list vms
    local nodes=( master_node_00 slave_node_01 slave_node_02 slave_node_03 )
    for node in "${nodes[@]}"; do
        local isrunning=$(${p} list runningvms | grep ${node})
        [[ -z $isrunning ]] && ${p} startvm ${node} --type headless
    done
}
k8s::down () {
    local p=$1
    ${p} list vms
    local nodes=( master_node_00 slave_node_01 slave_node_02 slave_node_03 )
    for node in "${nodes[@]}"; do
        local isrunning=$(${p} list runningvms | grep ${node})
        [[ -n $isrunning ]] && ${p} controlvm ${node} poweroff
    done
}

k8s::Darwin::up () {
    k8s::up $(k8s::Darwin::path)
}
k8s::Darwin::down () {
    k8s::down $(k8s::Darwin::path)
}

k8s::Darwin::path () {
    echo $_vm_path || { return 1; }
    return 0
}

k8s::Darwin () {
    local vm_path=/Applications/VirtualBox.app/Contents/MacOS/VBoxManage
    export _vm_path=$vm_path
    [[ ! -x ${vm_path} ]] && \
        echo "VirtualBox is not installed on this host" && \
        return 1
    return 0
}

k8s::setup () {
    local platform=$(uname)
    export _platform=$platform
    k8s::${platform} || { echo "${platform} not yet supported or missing configuration"; return 1; }
    return 0
}

launch_cluster () {
    local cmd=$1
    : ${cmd:?"missing commands: up or down"}
    k8s::setup || { echo "Unable to setup environment"; return 1; }
    k8s::${_platform}::$1 || { echo "command not supported $1"; return 1; }
    return $?
}
