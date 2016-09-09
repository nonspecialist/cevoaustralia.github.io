FROM ruby

VOLUME [ "/data"]

ADD . /data

EXPOSE 4000

WORKDIR "/data"

RUN bundle install

CMD [ "jekyll", "serve" ]
