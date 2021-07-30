Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v7 (Rapsberry Pi)

# Usage
```
docker pull lasery/caddy
docker run --rm lasery/caddy
```

# Development

## Set enviornment
```
cd caddy
```

## Build image
```
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy only
```

## Start the program
```
docker run --name=caddy-dev \
  -it --rm \
  caddy \
  sh
```

## Deploy image
```
./build.sh push
```

# Issues

