FROM extvos/centos

MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV MONGODB_VERSION 3.0.5

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

COPY entrypoint.sh /entrypoint.sh

RUN yum install -y ca-certificates \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
	&& chmod +x /usr/local/bin/gosu 
	
# https://repo.mongodb.org/yum/redhat/mongodb-org-3.0.repo
RUN cd /opt && curl https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel62-${MONGODB_VERSION}.tgz | tar zxv \
	&& ln -s /opt/mongodb-linux-x86_64-rhel62-${MONGODB_VERSION} /opt/mongodb \
	&& chmod +x /entrypoint.sh

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
ENV PATH /opt/mongodb/bin:${PATH}
VOLUME /data/db

ENTRYPOINT ["/entrypoint.sh"]


EXPOSE 27017
CMD ["mongod"]