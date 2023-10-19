dev() {
docker run \
    -it \
    --entrypoint= \
    --privileged `#make it work first, then security` \
    -v $(get_host_pwd)/tmp:/tmp \
    -v $(get_host_pwd)/app:/app \
    --rm \
    --name my-app \
    --network ride_network \
    -v $(get_host_pwd)/tmp/application_default_credentials.json:/tmp/application_default_credentials.json:ro \
    -e CREDENTIALS=/tmp/application_default_credentials.json \
    my-app \
    bash
}

dev_root() {
docker exec -it -u root jest-puppeteer bash
}

build() {
python3 ~/mbuild/utils/build.py docker
}
