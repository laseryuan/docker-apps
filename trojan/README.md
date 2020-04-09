Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/trojan
docker run --rm lasery/trojan
```

# Development

## Set enviornment
```
export REPO=trojan && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/trojan
```

## Build image
```
./build.sh docker
```

## Start the program
Prepare environment
```
  -e DOMAIN=\

  -p 80:80 -p 443:443 -p 80:80/udp -p 443:443/udp \
  -v $(pwd)/web/ssl/:/root/.caddy/ \
  -v $(pwd)/web/ssl/acme/acme-v02.api.letsencrypt.org/sites/:/etc/trojan/certs/ \
  -v $(pwd)/web/:/usr/src/ \
```

optional
```
  -e DEBUG=true
  -e PASSWORDS="[\"password1\", "\password2\"]"
```

for development
```
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/trojan/tmpl/ \
```

```
docker run --name=trojan-dev \
  -it --rm \
  trojan \
  sh

  server
  client
```

## Deploy image
```
./build.sh push
./build.sh deploy
```

# Issues

