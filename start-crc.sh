#!/bin/bash

# Exit on error
set -e


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${DIR}/common.sh

header_text "Executing start on host"
ssh $CLUSTER_HOST -t '/home/aliok/host/start-crc.sh'

error_text "Now run this:"
error_text "${DIR}/start-crc-local-dns-config.sh"
