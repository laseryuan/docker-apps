# Use the official Node.js base image
FROM lasery/devjs

ARG USER=node

# node image default node user id is 1000
ARG UID=1000
ARG GID=1000
# default password for user
ARG PW=docker

USER root

RUN \
    apt-get update && \
    apt-get install -y vim

# create user
RUN if ! [ "$UID" -eq 1000 ]; then \
        echo "Changing user UID to: ${UID}"; \
        usermod --uid=${UID} --gid=${GID} ${USER}; \
    fi

WORKDIR /home/$USER/node_app
RUN chown -R node:node /home/$USER/node_app

# Using unencrypted password/ specifying password
RUN "$(getent passwd ${UID} | cut -d: -f1):${PW}" | chpasswd

USER node

# Copy package.json and package-lock.json first to leverage Docker cache
COPY --chown=node:node app/package*.json ./

# Install the application's dependencies inside the container
RUN \
    npm install --no-optional && npm cache clean --force

ENV PATH=/home/$USER/node_app/node_modules/.bin:$PATH

WORKDIR /home/$USER/node_app/app
# Copy the rest of the application code into the container
COPY --chown=${UID}:${GID} app .
COPY --chown=${UID}:${GID} README.md /
