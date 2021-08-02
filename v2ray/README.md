Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker pull lasery/v2ray
docker run --rm lasery/v2ray
```

# Development

## Start the program
```
docker run -it --rm --name=v2ray-dev \
  v2ray:amd64 \
  bash
  server
  client
```

Run
```
docker exec -it v2ray-dev bash
/docker-entrypoint.sh server
/docker-entrypoint.sh client
```

### environment (Demand)
```
  -e DOMAIN=\
  -e V2RAY_ID=\
```

for server:
```
  -p 80:80 -p 443:443 -p 80:80/udp -p 443:443/udp \
```

for client:
```
  -p 1080:1080 -p 1080:1080/udp \
```

### environment (Optional)
```
  -e DEBUG=true \
  -e WS_PATH="/two" \
```

### Mount code
```
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/tmpl/:/etc/v2ray/tmpl/ \
```

Provide web:
```
  -v $(pwd)/web/:/tmp/web/ \
```

Provide ssl certificate:
```
  -v $(pwd)/web/ssl/:/root/.caddy/ \
```

## Build image
Set enviornment
```
cd v2ray
```

```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py docker --bake-arg "--progress plain --set *.cache-from=lasery/ride:latest"
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```
