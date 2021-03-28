# Kubernetes guest for Lenovo host

Available at https://github.com/aliok/kube-guest

To be used in conjunction with https://github.com/aliok/kube-host

To be placed at `~/guest`.

## kind

Start:

```
~/start-kind.sh
```

Dashboard doesn't work. See https://stackoverflow.com/questions/53957413/how-to-access-kubernetes-dashboard-from-outside-network
~

## crc

See https://github.com/aliok/kube-host for the DNS fuck up I had.

See https://www.opensourcerers.org/2021/03/22/accessing-a-remote-codeready-containers-installation-with-macos/

On Mac, I had to
- install dnsmasq to resolve DNS requests for the *.testing domain with the Lenovo IP
- set resolver config to use the local dnsmasq server as a DNS resolver for *.testing domain
- had to manually add 127.0.0.1 as a DNS server in Network Preferences since #2 above didn't really work

Start:

```
~/start-crc.sh
~/start-crc-local-dns-config.sh
~/start-crc-login.sh
```
