FROM intxlog/ubuntu1804

RUN echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu bionic main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12

RUN apt-get update

RUN apt-get install --assume-yes --no-install-recommends --no-install-suggests \
    redis-server

RUN apt-get purge --assume-yes --auto-remove \
    --option APT::AutoRemove::RecommendsImportant=false \
    --option APT::AutoRemove::SuggestsImportant=false
RUN rm -rf /var/lib/apt/lists/*

COPY etc/redis /etc/redis
COPY docker-entrypoint.sh /usr/local/bin/

RUN chown root:root /usr/local/bin/*
RUN chmod 755 /usr/local/bin/*

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["redis-server", "/etc/redis/redis.conf"]
