#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CRC_SERVER_IP="192.168.0.151"

source ${DIR}/common.sh

header_text "Executing start on host"
ssh lenovo -t '/home/aliok/host/start-crc.sh'

error_text "Now run ${DIR}/start-crc-local-dns-config.sh"
