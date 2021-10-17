cp /opt/certs/registry.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust
systemctl restart docker
