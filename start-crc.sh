#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CRC_SERVER_IP="192.168.1.151"

source ${DIR}/common.sh

header_text "Executing start on host"
ssh lenovo -t '/home/aliok/host/start-crc.sh'

header_text "Copying KUBECONFIG file into ${DIR}/crc.kubeconfig"
scp lenovo:/home/aliok/.crc/machines/crc/kubeconfig ${DIR}/crc.kubeconfig

# header_text "Renaming the context in new KUBECONFIG file"
# KUBECONFIG=${DIR}/crc.kubeconfig kubectl config rename-context admin crc-lenovo

header_text "Renaming the cluster and the context in new KUBECONFIG file"
sed -i 's/cluster: crc/cluster: crc-lenovo/g' ${DIR}/crc.kubeconfig
sed -i 's/name: crc/name: crc-lenovo/g' ${DIR}/crc.kubeconfig
sed -i 's/name: admin/name: crc-lenovo/g' ${DIR}/crc.kubeconfig

header_text "Merging KUBECONFIG file into the ~/.kube/config"
KUBECONFIG=~/.kube/config:${DIR}/crc.kubeconfig kubectl config view --merge --flatten > ~/.kube/config

header_text "Switching to new context"
kubectx crc-lenovo

error_text "Now run ${DIR}/start-crc-sudo.sh"
