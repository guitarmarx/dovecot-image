#!/bin/sh
set -e

# doku: https://wiki.dovecot.org/HowTo/DovecotOpenLdap

ldap_config="/etc/dovecot/dovecot-ldap.conf.ext"
sed -i "s|#hosts =|hosts = '$LDAP_HOST'|g" $ldap_config
sed -i "s|#auth_bild =.*|auth_bind = yes|g" $ldap_config
sed -i "s|base =|base = '$LDAP_BASE'|g" $ldap_config

cp /srv/templates/dovecot.conf /etc/dovecot/dovecot.conf

#start dovecot
dovecot -F  2>&1 |  tee /var/log/dovecot.log