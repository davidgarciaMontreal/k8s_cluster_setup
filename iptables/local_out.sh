#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd ${DIR} &>/dev/null
source common.sh

OUTPUT=(raw mangle nat filter)
POSTROUTING=(mangle nat)
opt=--list$1
ip::looper "OUTPUT" "${opt}" "${OUTPUT[@]}"
ip::looper "POSTROUTING" "${opt}" "${POSTROUTING[@]}"
