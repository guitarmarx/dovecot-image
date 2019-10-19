FROM alpine:3.10.2
LABEL maintainer="meteorIT GbR Marcus Kastner"

EXPOSE 143 2003
VOLUME /etc/dovecot
VOLUME /var/vmail/mailboxes

ENV DB_HOST="" \
    DB_PORT=3306 \
    DB_NAME=dovecot \
    DB_USER=dovecot \
    DB_PASS=dovecot \
    DOCKERIZE_VERSION=v0.6.1

ADD templates /srv/templates
ADD entrypoint.sh /srv

# create user
RUN addgroup -S -g 500 vmail \
    && adduser -S -u 501 -D -s /sbin/nologin  -H -h /dev/null  -G vmail -g vmail vmail

RUN apk add --update --no-cache \
    dovecot \
    dovecot-lmtpd \
    dovecot-mysql \
    dovecot-core \
    mysql-client \
    curl \
    tar

RUN curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz --output /tmp/dockerize.tar.gz  \
    && tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz \
    && rm /tmp/dockerize.tar.gz

RUN mkdir /var/vmail \
    && chmod 777 /srv/entrypoint.sh

ENTRYPOINT /srv/entrypoint.sh