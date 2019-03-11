FROM alpine:3.9.2
LABEL maintainer="meteorIT GbR Marcus Kastner"

EXPOSE 143 2003

ENV DB_HOST="" \
    DB_NAME=vmail \
    DB_USER=vmail \
    DB_PASS=vmail \
    DOCKERIZE_VERSION=v0.6.1

ADD templates /srv/templates
ADD entrypoint.sh /srv

RUN apk add --update --no-cache \
    dovecot \
    dovecot-lmtpd \
    dovecot-mysql \
    curl \
    tar

RUN curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz --output /tmp/dockerize.tar.gz  \
    && tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz \
    && rm /tmp/dockerize.tar.gz

RUN rm -r /etc/dovecot/* \
    && mkdir /var/vmail \
    && chmod -R 770 /var/vmail \
    && chmod 777 /srv/entrypoint.sh

ENTRYPOINT /srv/entrypoint.sh

# docker run -it --rm --name test alpine:3.9.2