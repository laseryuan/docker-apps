FROM node:22-bookworm-slim

ENV NODE_ENV=production \
    NPM_CONFIG_UPDATE_NOTIFIER=false \
    NPM_CONFIG_FUND=false \
    NPM_CONFIG_AUDIT=false

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        openssh-client \
        python3 \
        ripgrep \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @openai/codex@{{IMAGE_VERSION}} \
    && npm cache clean --force

USER node
WORKDIR /workspace

ENTRYPOINT ["codex"]
CMD ["--help"]
