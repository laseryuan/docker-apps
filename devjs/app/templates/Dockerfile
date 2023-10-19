# Use the official Node.js base image
FROM devjs:amd64

ARG USER=node

# node image default node user id is 1000
ARG UID=1000
ARG GID=1000
# default password for user
ARG PW=docker
# create user
RUN echo "$UID"
RUN if ! [ "$UID" -eq 1000 ]; then \
        useradd -m ${USER} --uid=${UID}; \
    fi

# Using unencrypted password/ specifying password
RUN "$(getent passwd ${UID} | cut -d: -f1):${PW}" | chpasswd

WORKDIR /home/$USER/node_app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY --chown=${UID}:${GID} app/package*.json ./

# Install the application's dependencies inside the container
RUN \
npm install --no-optional && npm cache clean --force
# RUN \
# npm install ${dev-packages}

ENV PATH=/home/$USER/node_app/node_modules/.bin:$PATH

WORKDIR /home/$USER/node_app/app
# Copy the rest of the application code into the container
COPY --chown=${UID}:${GID} app .
COPY --chown=${UID}:${GID} README.md /
