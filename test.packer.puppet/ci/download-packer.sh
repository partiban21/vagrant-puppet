#!/bin/bash -eu

: "${PACKER_VERSION:=1.6.4}"

yum install unzip -y
curl "${REKT_REPO_URL}/hashicorp/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" -o packer.zip
unzip packer.zip
./packer --help
mkdir dependencies && mv packer dependencies/
