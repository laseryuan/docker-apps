Config() {
. tmp/env.sh
# . tmp/dev.env.sh

echo "Using config: $GCLOUD_CONFIG"
}
Config

dev() {
# export DISPLAY=:1
docker run \
    --privileged `#make it work first, then security` \
    -v /dev/shm:/dev/shm \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -it --rm \
    --name=$APP_NAME \
    -v $(get_host_pwd)/app:/home/node/node_app/app \
    -v $(get_host_pwd)/app/package.json:/home/node/node_app/package.json \
    -v $(get_host_pwd)/app/package-lock.json:/home/node/node_app/package-lock.json \
    -v $(get_host_pwd)/tmp/:/apptmp/ \
    --network=ride_network \
    $APP_NAME bash
}

# start web server for static site
server() {
docker exec -id \
    -w /home/node/node_app/app/src \
    $APP_NAME \
    live-server --no-browser
}

# open headless browser
headless() {
docker exec -it \
    -w /home/node/node_app/app/ \
    $APP_NAME \
    node remote.js

clean
}

repl() {
exec crconsole --host 127.0.0.1
}

# open ui browser
browser() {
docker exec -d $APP_NAME \
google-chrome --remote-debugging-port=9222 --remote-debugging-address=0.0.0.0 --no-sandbox $@
}

# locus work arround
clean() {
docker exec -it \
    $APP_NAME \
    bash -c "rm /home/node/node_modules/locus/histories/*"
}

exec() {
docker exec -it $APP_NAME $@
}

exec_root() {
docker exec -it -u root $APP_NAME $@
}

build() {
docker build \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -u) \
    -t $APP_NAME .
}
