#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CRC_SERVER_IP="192.168.1.151"

source ${DIR}/common.sh

whoami

header_text "Setting up local DNS resolver settings"
sudo mkdir -p /etc/resolver
sudo rm /etc/resolver/testing || true
sudo touch /etc/resolver/testing
sudo chmod 666 /etc/resolver/testing
# Following didn't work and I had to install dnsmasq locally on the Mac
# sudo echo "nameserver ${CRC_SERVER_IP}" >> /etc/resolver/testing
sudo echo "nameserver 127.0.0.1" >> /etc/resolver/testing
sudo echo "port 53" >> /etc/resolver/testing
sudo echo "domain testing" >> /etc/resolver/testing
sudo echo "search_order 1" >> /etc/resolver/testing

header_text "Setting up dnsmasq settings"
tee /usr/local/etc/dnsmasq.conf &>/dev/null <<EOF
address=/apps-crc.testing/${CRC_SERVER_IP}
address=/api.crc.testing/${CRC_SERVER_IP}
EOF

header_text "Restarting dnsmasq"
sudo brew services start dnsmasq

error_text "Make sure you have 127.0.0.1 and 8.8.8.8 in your DNS settings in 'Network Preferences'"
