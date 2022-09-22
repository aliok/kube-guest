#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${DIR}/common.sh

header_text "Printing cluster info"
ssh $CLUSTER_HOST "crc console --credentials"

header_text "Deleting existing ${DIR}/crc.kubeconfig"
rm ${DIR}/crc.kubeconfig || true
touch ${DIR}/crc.kubeconfig

header_text "Logging in as kubeadmin with a new kubeconfig file at ${DIR}/crc.kubeconfig"
KUBEADMIN_PW=$(ssh $CLUSTER_HOST "crc console --credentials --output json" | jq -r '.clusterConfig.adminCredentials.password')
KUBECONFIG=${DIR}/crc.kubeconfig oc login -u kubeadmin -p ${KUBEADMIN_PW} https://api.crc.testing:6443 --insecure-skip-tls-verify=true

header_text "Renaming the cluster and the context in KUBECONFIG file"
KUBECONFIG=${DIR}/crc.kubeconfig kubectl config rename-context default/api-crc-testing:6443/kubeadmin crc-lenovo
sed -i 's/name: api-crc-testing:6443/name: crc-lenovo/g' ${DIR}/crc.kubeconfig
sed -i 's/cluster: api-crc-testing:6443/cluster: crc-lenovo/g' ${DIR}/crc.kubeconfig

header_text "Merging KUBECONFIG file into the ~/.kube/config"
KUBECONFIG=~/.kube/config:${DIR}/crc.kubeconfig kubectl config view --merge --flatten > ~/.kube/tmp.config
mv ~/.kube/tmp.config ~/.kube/config

header_text "Switching to new context"
kubectx crc-lenovo


error_text "Now open https://api.crc.testing:6443"
header_text "kubeadmin password"
header_text $KUBEADMIN_PW
