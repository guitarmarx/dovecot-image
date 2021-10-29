FROM alpine:3.14
LABEL maintainer="meteorIT GbR Marcus Kastner"

EXPOSE 143 2003

ADD templates /srv/templates
ADD entrypoint.sh /srv

ENV LDAP_HOST=localhost \
	LDAP_BASE=ou=group,dc=domain,dc=net

RUN apk add --update --no-cache \
    dovecot \
    dovecot-lmtpd \
	dovecot-ldap \
	dovecot-pigeonhole-plugin

RUN ln -s /etc/dovecot/dovecot-ldap.conf.ext /etc/dovecot/dovecot-ldap-userdb.conf.ext \
	&& chmod +x /srv/entrypoint.sh

ENTRYPOINT /srv/entrypoint.sh