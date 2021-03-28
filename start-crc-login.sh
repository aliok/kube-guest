#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${DIR}/common.sh

header_text "Printing cluster info"
ssh lenovo "crc console --credentials"

header_text "Logging in as kubeadmin"
KUBEADMIN_PW=$(ssh lenovo "crc console --credentials --output json" | jq -r '.clusterConfig.adminCredentials.password')
oc login -u kubeadmin -p ${KUBEADMIN_PW} https://api.crc.testing:6443

error_text "Now open https://api.crc.testing:6443"
header_text "kubeadmin password"
header_text $KUBEADMIN_PW
