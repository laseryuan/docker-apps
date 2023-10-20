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

# start web server for static site
server() {
docker exec -id \
    -w /home/node/node_app/app/src \
    devjs-app \
    live-server --no-browser
}

# open ui browser
browser() {
docker exec -id devjs-app \
google-chrome --remote-debugging-port=9222 --remote-debugging-address=0.0.0.0 --no-sandbox $@
}

# open headless browser
headless() {
docker exec -it \
    -w /home/node/node_app/app/ \
    devjs-app \
    node remote.js

clean
}

# locus work arround
clean() {
docker exec -it \
    devjs-app \
    bash -c "rm /home/node/node_modules/locus/histories/*"
}

exec() {
docker exec -it devjs-app $@
}

exec_root() {
docker exec -it -u root devjs-app $@
}

build() {
docker build \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -u) \
    -t devjs-app .
}
