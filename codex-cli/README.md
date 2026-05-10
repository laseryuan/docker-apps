# codex-cli

Docker image for [OpenAI Codex CLI](https://github.com/openai/codex), a local coding agent that runs in your terminal.

## Usage

Pull the image:

```sh
docker pull lasery/codex-cli
```

Run Codex in the current project directory:

```sh
docker run --rm -it \
  -v "$PWD:/workspace" \
  -v "$HOME/.codex:/home/node/.codex" \
  -w /workspace \
  lasery/codex-cli
```

Run a one-off prompt:

```sh
docker run --rm -it \
  -v "$PWD:/workspace" \
  -v "$HOME/.codex:/home/node/.codex" \
  -w /workspace \
  lasery/codex-cli "explain this repository"
```

Use an API key instead of the mounted Codex config directory:

```sh
docker run --rm -it \
  -e OPENAI_API_KEY \
  -v "$PWD:/workspace" \
  -w /workspace \
  lasery/codex-cli
```

## Build image

```sh
cd codex-cli
python3 ~/mbuild/utils/build.py docker
python3 ~/mbuild/utils/build.py push --only
python3 ~/mbuild/utils/build.py deploy --only
```
