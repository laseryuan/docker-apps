picam Docker Multi-Architecture Images

Works for both amd64 (Ubuntu) and arm32v6 (Rapsberry Pi)

# Usage
```
docker run --rm lasery/picam

docker run --privileged -d --name picam lasery/picam \
  start # Start without recording. Default parameter: "--noaudio". Can feed in parameters by append them to the end.

  -v $(pwd)/hooks.sh:/home/picam/hooks.sh `# custom script to run when picam started`\
  -v $(pwd)/:/home/picam/ `# save records in current directory`\
```

# Development
Fist time setup
```
gem install mustache
utils/build.tmpl.sh config && chmod +x build/build.sh
```

## Set enviornment
```
cd ~/projects/docker-apps/picam
```

## Build image
```
build/build.sh config
build/build.sh docker
build/build.sh push
build/build.sh deploy
```

## Start the program
```
  -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static \
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  -v $(pwd)/hooks.sh:/home/picam/hooks.sh \
  -v $(pwd)/:/home/picam/ \

docker run -it --rm --name picam \
  --privileged \
  picam:armv6 \
  bash

  start # Start without recording. Default parameter: "--noaudio". Can feed in parameters by append them to the end.

  picam:build-armv6 `# For build image` \
```
