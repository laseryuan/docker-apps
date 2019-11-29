# Usage
```
docker pull lasery/ansible
docker run --rm lasery/ansible help
```

# Development

## Set variables
```
export REPO=ansible && export VERSION=$(date "+%y.%m") && cd ~/projects/docker-apps/ansible
./build.sh docker
```

## Build image
- Local
```
docker buildx bake

./build.sh push
```
