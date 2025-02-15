dev() {
docker run \
    --privileged \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -it --rm \
    --name devjs \
    --network ride_network \
    -v $(get_host_pwd)/test:/home/node/test \
    devjs:amd64 \
    bash
}

dev_image() {
docker run \
    -it \
    --platform linux/amd64 \
    devjs:amd64 \
    bash
}

npm_install() {
cd ~/node_app/
npm install --save-dev $@
}

exec() {
docker exec -it devjs bash
}

exec_root() {
docker exec -it -u root devjs bash
}

build() {
python3 ~/mbuild/utils/build.py docker
}

deploy() {
build
python3 ~/mbuild/utils/build.py deploy
}
