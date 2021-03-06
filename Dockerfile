FROM debian:jessie
MAINTAINER daijinming <daijinming@live.cn>


ENV OPENFIRE_VERSION=4.2.3 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip vim ntpdate ntp openjdk-8-jre sudo \
 && echo "Downloading openfire_${OPENFIRE_VERSION}_all.deb ..." \
 && wget --no-verbose "http://arc.elef.top/openfire/openfire_${OPENFIRE_VERSION}_all.deb" -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
 && rm -rf openfire_${OPENFIRE_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 5275/tcp 5276/tcp 5262/tcp 5263/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp

VOLUME ["${OPENFIRE_DATA_DIR}"]
VOLUME ["${OPENFIRE_LOG_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
