#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${DIR}/common.sh

header_text "Executing start on host"
ssh lenovo -t '/home/aliok/host/start-kind-multinode.sh'

header_text "Copying KUBECONFIG file into ${DIR}/kind.kubeconfig"
scp lenovo:/home/aliok/host/kind.kubeconfig ${DIR}/kind.kubeconfig

# TODO: maybe change the cluster name and context name first?

header_text "Merging KUBECONFIG file into the ~/.kube/config"
KUBECONFIG=~/.kube/config:${DIR}/kind.kubeconfig kubectl config view --merge --flatten > ~/.kube/config

header_text "Switching to new context"
kubectx kind-lenovo
