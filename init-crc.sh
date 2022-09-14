#!/bin/bash

# Exit on error
set -e


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${DIR}/common.sh

header_text "Asking sudo for using later"
sudo echo ok

header_text "Executing start on host"
ssh $CLUSTER_HOST -t '/home/aliok/host/start-crc.sh'

error_text "Now run ${DIR}/init-crc-local-dns-config.sh"
