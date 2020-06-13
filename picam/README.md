[picam](https://github.com/iizukanao/picam) docker multi-architecture image for raspberry pi

# Usage
```
docker run --rm lasery/picam

docker run --privileged lasery/picam start # Start with default hooks to record 30 seconds video. Default picam parameter: "--noaudio". You can customize the parameters by appending them to the end.

  -v $(pwd)/hooks.sh:/home/picam/hooks.sh `# use custom hooks script`\
  -v $(pwd)/:/home/picam/ `# save records in current directory`\

picam parameters are save in ~/picam_param
```

# Development
```
cd ~/projects/docker-apps/picam
```

## Build image
```
append "skip" to skip compile bake and dockerfiles
utils/build.py docker
utils/build.py push
utils/build.py deploy
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

  start

  picam:build-armv6 `# For build image` \
```
