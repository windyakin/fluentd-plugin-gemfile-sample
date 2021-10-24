FROM fluent/fluentd:v1.13-debian

COPY Gemfile /fluentd/etc/

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER fluent

RUN cd /fluentd/etc \
  && bundle install -j8 --path vendor/bundle

CMD [ "fluentd", "--gemfile", "/fluentd/etc/Gemfile" ]
