# Usage
```
docker run --rm lasery/ss-tproxy help
```

# Development

## Set enviornment
```
export REPO=ss-tproxy && export VERSION=$(date "+%y.%m")
cd ~/projects/docker-apps/ss-tproxy
```

## Build image
```
./build.sh docker
docker buildx bake
```

```
  -e DEBUG=true \
  -e USE_REDSOCKS=false \
  -e SSTP_CONFIG="mode=gfwlist" \
  -e DOCKER_NET \

  -e HOST_ADDRESS=\
  -e SOCKS_IP=\
  -e SOCKS_PORT=\

  -v $(pwd)/redsocks/redsocks-fw.sh:/usr/local/bin/redsocks-fw.sh
  -v $(pwd)/redsocks/redsocks.tmpl:/etc/redsocks.tmpl
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/ss-tproxy/tmpl/ \

docker run --privileged=true --net=host --sysctl net.ipv4.conf.all.route_localnet=1 --name ss-tproxy \
  -it --rm \
  ss-tproxy \
  bash

  sstproxy

curl ipinfo.io/ip

sudo watch -d iptables -t nat -L --line-numbers -v -n

sudo iptables -t nat -D PREROUTING 2
sudo iptables -t nat -D OUTPUT 2
```


# TODO
1. Run without "--net=host"
How to deal with "ip rule add" and "ip route add" in ssr-iptables.sh
