# clasp

Docker image for [`@google/clasp`](https://github.com/google/clasp), the Google Apps Script command line tool.

## Usage

```sh
docker pull lasery/clasp
```

Run clasp commands in the current Apps Script project directory:

```sh
docker run --rm -it \
  -v "$PWD:/home/node/app" \
  -v "$HOME/.clasprc.json:/home/node/.clasprc.json" \
  lasery/clasp --help
```

Authenticate first if you do not already have a `~/.clasprc.json` file:

```sh
docker run --rm -it \
  -v "$HOME:/home/node" \
  lasery/clasp login --no-localhost
```

Common commands:

```sh
docker run --rm -it -v "$PWD:/home/node/app" -v "$HOME/.clasprc.json:/home/node/.clasprc.json" lasery/clasp pull
docker run --rm -it -v "$PWD:/home/node/app" -v "$HOME/.clasprc.json:/home/node/.clasprc.json" lasery/clasp push
```

## Build image

```sh
cd clasp
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```
