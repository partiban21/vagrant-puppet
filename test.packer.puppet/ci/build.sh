#!/bin/bash -eu

: "${ARTEFACTS_PATH:?must be set}"

dependencies/packer build "$1"

mkdir -p "${ARTEFACTS_PATH}/customer-facing"
mv *.box "${ARTEFACTS_PATH}/customer-facing/"
