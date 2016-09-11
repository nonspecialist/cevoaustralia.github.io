FROM ruby:alpine

VOLUME [ "/data"]

ADD . /data

EXPOSE 4000

WORKDIR "/data"

RUN apk update && apk upgrade && apk add ruby-dev build-base && \
    bundle install

CMD [ "jekyll", "serve" ]
