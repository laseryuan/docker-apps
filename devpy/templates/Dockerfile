FROM lasery/devpy

# if not FROM devpy image
RUN \
  pip install ipdb pytest behave pipenv

USER 1000
ENV HOME=/tmp

# install poetry nox
RUN \
    curl -sSL https://install.python-poetry.org | python3 - && \
    pip install --user --upgrade nox pre-commit

# add PATH
ENV PATH="$PATH:/tmp/.local/bin"

# copy repository
COPY --chown=1000 $REPO /tmp/data/$REPO

WORKDIR /tmp/data/$REPO/

# install dependencies
RUN \
    poetry install && \
    pre-commit install
