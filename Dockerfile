FROM python:3.5

ENV SRC=//src
ENV WORKDIR=//src/docs

ADD ./src $SRC
RUN git clone https://github.com/ovh/docs-rendering.git $WORKDIR
WORKDIR $WORKDIR
RUN mkdir pages
RUN mkdir output

VOLUME ["$WORKDIR/pages/"]

RUN pip install -r requirements.txt
RUN chmod +x $SRC/entrypoint.sh

EXPOSE 8080
CMD $SRC/entrypoint.sh
