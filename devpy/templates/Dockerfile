FROM lasery/devpy

ARG REPO=app

RUN \
    pip install \
        ipdb pytest behave pipenv `# if base image is not lasery/devpy` \
        poetry nox pre-commit \
        ``

# copy repository
COPY $REPO /tmp/data/$REPO

WORKDIR /tmp/data/$REPO/

# install dependencies
RUN \
    poetry install
