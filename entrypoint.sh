#!/bin/sh
set -e

# doku: https://wiki.dovecot.org/HowTo/DovecotOpenLdap

ldap_config="/etc/dovecot/dovecot-ldap.conf.ext"
sed -i "s|#hosts =|hosts = '$LDAP_HOST'|g" $ldap_config
sed -i "s|#auth_bind =.*|auth_bind = yes|g" $ldap_config
sed -i "s|base =|base = '$LDAP_BASE'|g" $ldap_config
sed -i -e "s|(uid=%u)|(uid=%n)|g" $ldap_config

cp /srv/templates/dovecot.conf /etc/dovecot/dovecot.conf

#start dovecot
dovecot -F  2>&1 |  tee /var/log/dovecot.log

test_dovecot.1.m4wbbxbw1eqhl4ee2n2uxv4xm