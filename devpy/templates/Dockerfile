FROM lasery/devpy

ARG REPO=app

# creat virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

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
