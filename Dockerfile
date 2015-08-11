FROM extvos/centos

MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV MONGODB_VERSION 3.0.5

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN cd /opt && curl https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel62-${MONGODB_VERSION}.tgz | tar zxv \
	&& ln -s /opt/mongodb-linux-x86_64-rhel62-${MONGODB_VERSION} /opt/mongodb

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

COPY docker-entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
ENV PATH /opt/mongodb/bin:${PATH}

EXPOSE 27017
CMD ["mongod"]