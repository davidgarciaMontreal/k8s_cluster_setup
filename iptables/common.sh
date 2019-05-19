#!/usr/bin/env bash

ip::looper () {
    local chain=$1 && shift 
    local opt=$1 && shift 
    local ARRAY=("$@")
    for f in "${ARRAY[@]}"; do
        echo "##############################################################"
        echo "----------table: ${f}|chain: ${chain}----------"
        echo "cmd: sudo iptables -t ${f} $opt ${chain}"
        sudo iptables -t ${f} ${opt} ${chain}
    done
}
