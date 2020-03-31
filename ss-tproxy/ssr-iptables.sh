#!/bin/bash
# Most of this is credited to
# https://blog.jessfraz.com/post/routing-traffic-through-tor-docker-container/
# https://trac.torproject.org/projects/tor/wiki/doc/TransparentProxy
# With a few minor edits

# to run iptables commands you need to be root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    return 1
fi

### set variables
# destinations you don't want routed through Tor
_non_tor="192.168.1.0/24 192.168.0.0/24"

# get the UID that Tor runs as
# _tor_uid=$(id -u tor)

# Tor's TransPort
_trans_port=$TPROXY_PORT

### route all trafic to local port
iptables -t nat -A PREROUTING -p tcp --syn ! --dport 22 -j REDIRECT --to-ports $_trans_port

### route all trafic to local port
ip rule add fwmark 0x01/0x01 table 100
ip route add local 0.0.0.0/0 dev lo table 100

iptables -t mangle -N SSUDP
iptables -t mangle -A SSUDP -p udp -j TPROXY --on-port $_trans_port --tproxy-mark 0x01/0x01
iptables -t mangle -A PREROUTING -j SSUDP

iptables -t mangle -I PREROUTING -d 127.0.0.0/24 -j RETURN
iptables -t mangle -I PREROUTING -d 192.168.0.0/16 -j RETURN
iptables -t mangle -I PREROUTING -d 10.42.0.0/16 -j RETURN
iptables -t mangle -I PREROUTING -d 0.0.0.0/8 -j RETURN
iptables -t mangle -I PREROUTING -d 10.0.0.0/8 -j RETURN
iptables -t mangle -I PREROUTING -d 172.16.0.0/12 -j RETURN
iptables -t mangle -I PREROUTING -d 224.0.0.0/4 -j RETURN
iptables -t mangle -I PREROUTING -d 240.0.0.0/4 -j RETURN
iptables -t mangle -I PREROUTING -d 169.254.0.0/16 -j RETURN
iptables -t mangle -I PREROUTING -d 255.255.0.0/8 -j RETURN

### set iptables *nat

# local requests
# iptables -t nat -A OUTPUT -m owner --uid-owner $_tor_uid -j RETURN

# allow clearnet access for hosts in $_non_tor
echo "Add $SERVER_IP to iptables"
_non_tor="127.0.0.0/9 127.128.0.0/10 $SERVER_IP"
for _clearnet in $_non_tor; do
   iptables -t nat -A OUTPUT -d $_clearnet -j RETURN
done

# redirect all other output to Tor's TransPort
iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $_trans_port

### set iptables *filter
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# allow clearnet access for hosts in $_non_tor
for _clearnet in $_non_tor 127.0.0.0/8; do
   iptables -A OUTPUT -d $_clearnet -j ACCEPT
done

# allow only Tor output
# iptables -A OUTPUT -m owner --uid-owner $_tor_uid -j ACCEPT
# iptables -A OUTPUT -j REJECT
