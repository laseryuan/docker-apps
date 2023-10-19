dev() {
docker run \
    -it \
    --rm \
    --name devjs \
    --network ride_network \
    devjs:amd64 \
    bash
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
