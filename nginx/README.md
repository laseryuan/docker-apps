Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/nginx
```

# Development
Fist time setup
```
gem install mustache
pip install pystache && pystache-test
pip install chevron pyyaml

utils/build.tmpl.sh config && chmod +x build/build.sh
```

## Set enviornment
```
cd ~/projects/docker-apps/nginx
```

## Start the program
Development
```
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \

  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
```

```
docker run --name=nginx --rm \
  -it \
  nginx:amd64 \
  bash
```


## Build image
```
append "skip" to skip compile bake and dockerfiles
utils/build.py docker
utils/build.py push
utils/build.py deploy
```

# Issues

