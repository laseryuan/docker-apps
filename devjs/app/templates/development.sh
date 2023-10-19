dev() {
docker run \
    --privileged `#make it work first, then security` \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -it --rm \
    --name=devjs-app \
    -v $(get_host_pwd)/app:/home/node/node_app/app \
    -v $(get_host_pwd)/app/package.json:/home/node/node_app/package.json \
    -v $(get_host_pwd)/app/package-lock.json:/home/node/node_app/package-lock.json \
    -v $(get_host_pwd)/tmp/:/apptmp/ \
    --network=ride_network \
    devjs-app bash
}

server() {
cd src
live-server
}

chrome() {
google-chrome --headless --remote-debugging-port=9222 --remote-debugging-address=0.0.0.0 --no-sandbox
}

exec() {
docker exec -it devjs-app bash
}

exec_root() {
docker exec -it -u root devjs-app bash
}

build() {
docker build \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -u) \
    -t devjs-app .
}
