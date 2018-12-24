#!/usr/bin/env bash
hostname=$1
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service
hostnamectl set-hostname ${hostname}
# change hostname under /etc/hostname