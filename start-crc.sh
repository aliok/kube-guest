#!/bin/bash

# Exit on error
set -e

./init-crc.sh
./init-crc-local-dns-config.sh
./init-crc-login.sh
