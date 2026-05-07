FROM node:20-alpine

ENV NODE_ENV=production
ENV NODE_PATH=/usr/local/lib/node_modules
ARG version=latest

RUN npm install -g @google/clasp@${IMAGE_VERSION} \
    && npm cache clean --force

USER node
WORKDIR /home/node/app

ENTRYPOINT ["clasp"]
CMD ["--help"]
