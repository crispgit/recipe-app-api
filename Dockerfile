FROM python:3.7-alpine
MAINTAINER Pengjie Zhou

# don't buffer output
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# create empty folder in docker image and copy local files to it
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

RUN adduser -D user
# switch to user
USER user
