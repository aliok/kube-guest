#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CLUSTER_NAME=lenovo

source ${DIR}/common.sh

header_text "Executing start on host"
ssh $CLUSTER_HOST -t '/home/aliok/host/start-kind-multinode.sh'

header_text "Copying KUBECONFIG file into ${DIR}/kind.kubeconfig"
scp $CLUSTER_HOST:/home/aliok/host/kind.kubeconfig ${DIR}/kind.kubeconfig

header_text "Deleting old Kind stuff in KUBECONFIG file ~/.kube/config"
KUBECONFIG=~/.kube/config kubectl config delete-user kind-${CLUSTER_HOST}
KUBECONFIG=~/.kube/config kubectl config delete-context kind-${CLUSTER_HOST}
KUBECONFIG=~/.kube/config kubectl config delete-cluster kind-${CLUSTER_HOST}

# TODO: maybe change the cluster name and context name first?

header_text "Merging KUBECONFIG file into the ~/.kube/config"
KUBECONFIG=~/.kube/config:${DIR}/kind.kubeconfig kubectl config view --merge --flatten > ~/.kube/tmp.config
mv ~/.kube/tmp.config ~/.kube/config

header_text "Switching to new context"
kubectx kind-lenovo
