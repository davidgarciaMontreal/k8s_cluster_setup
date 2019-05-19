#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd ${DIR} &>/dev/null
source common.sh

PREROUTING=(raw mangle nat)
INPUT=(mangle filter)
opt=--list$1
ip::looper "PREROUTING" "${opt}" "${PREROUTING[@]}"
ip::looper "INPUT" "${opt}" "${INPUT[@]}"
