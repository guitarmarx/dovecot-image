FROM alpine:3.14
LABEL maintainer="meteorIT GbR Marcus Kastner"

EXPOSE 143 993 2003

ADD templates /srv/templates
ADD entrypoint.sh /srv

ENV LDAP_HOST=localhost \
	LDAP_BASE="ou=group,dc=domain,dc=net" \
	LDAP_FILTER="(\&(objectClass=posixAccount)(uid=%n))" \
	LDAP_LOGIN_USER='' \
	LDAP_LOGIN_PASSWORD='' \
	ENABLE_AUTH_BIND=no \
	AUTH_BIND_USER_DN='' \
	UID='90' \
	GID='500' \
	ENABLE_SSL='yes' \
	SSL_KEY_FILE='/etc/ssl/dovecot/certs/cert.key' \
	SSL_CERT_FILE='/etc/ssl/dovecot/certs/cert.crt'



RUN apk add --update --no-cache \
    dovecot \
    dovecot-lmtpd \
	dovecot-ldap \
	dovecot-pigeonhole-plugin

RUN ln -s /etc/dovecot/dovecot-ldap.conf.ext /etc/dovecot/dovecot-ldap-userdb.conf.ext \
	mkdir -p  /etc/ssl/dovecot/certs \
	&& chmod +x /srv/entrypoint.sh

HEALTHCHECK CMD netstat -plnt |  grep '143'
ENTRYPOINT /srv/entrypoint.sh