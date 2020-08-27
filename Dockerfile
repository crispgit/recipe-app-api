FROM python:3.7-alpine
MAINTAINER Pengjie Zhou

# don't buffer output
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# create empty folder in docker image and copy local files to it
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

RUN adduser -D user
# switch to user
USER user