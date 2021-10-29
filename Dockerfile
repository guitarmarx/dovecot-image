FROM alpine:3.14
LABEL maintainer="meteorIT GbR Marcus Kastner"

EXPOSE 143 2003
VOLUME /etc/dovecot

ADD templates /srv/templates
ADD entrypoint.sh /srv

ENV LDAP_HOST=localhost \
	LDAP_BASE=ou=group,dc=domain,dc=net

RUN apk add --update --no-cache \
    dovecot \
    dovecot-lmtpd \
	dovecot-ldap \
	dovecot-pigeonhole-plugin

RUN  chmod +x /srv/entrypoint.sh

ENTRYPOINT /srv/entrypoint.sh