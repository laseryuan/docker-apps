dev() {
docker run \
    -it \
    --rm \
    --name devjs \
    --network ride_network \
    devjs:amd64 \
    bash
}

dev_root() {
docker exec -it -u root jest-puppeteer bash
}

build() {
python3 ~/mbuild/utils/build.py docker
}
