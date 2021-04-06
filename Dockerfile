FROM python:3.9.4

LABEL \
  maintainer="OVHcloud team" \
  description="Image used to locally build the docs.ovh.com documentation."

ENV \
  SRC=/src \
  WORKDIR=/src/docs

ADD ./src $SRC
RUN git clone --recurse-submodules https://github.com/ovh/docs-rendering.git $WORKDIR
WORKDIR $WORKDIR
RUN \
  mkdir -p pages output && \
  pip install -r requirements.txt && \
  chmod +x $SRC/entrypoint.sh

VOLUME ["$WORKDIR/pages/"]
EXPOSE 8080

CMD $SRC/entrypoint.sh
