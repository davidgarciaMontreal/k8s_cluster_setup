#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
# /etc/pki/tls/openssl.cnf
master_ip="192.168.50.4"
# set under v3_ca section : subjectAltName = IP:master_ip
# see ldap spec https://datatracker.ietf.org/doc/html/rfc4514
# X.500 Distinguished Names are used to identify entities,
#  such as those which are named by the subject and issuer
#  (signer) fields of X.509 certificates.
# String  X.500 AttributeType
# ------  --------------------------------------------
# CN      commonName (2.5.4.3)
# L       localityName (2.5.4.7)
# ST      stateOrProvinceName (2.5.4.8)
# O       organizationName (2.5.4.10)
# OU      organizationalUnitName (2.5.4.11)
# C       countryName (2.5.4.6)
# STREET  streetAddress (2.5.4.9)
# DC      domainComponent (0.9.2342.19200300.100.1.25)
# UID     userId (0.9.2342.19200300.100.1.1)
# Certificate : .crt or .cer X509v3 type.
cd /opt and mkdir -p certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout \
 ./certs/registry.key -x509 -days 365 -out ./certs/registry.crt \
 -subj "/E=user@e-corp.com/C=CA/ST=QC/L=Montreal/O=Garcia-Inc/OU=dev-team/CN=${master_ip}"
openssl x509 -in certs/registry.crt -noout -text
