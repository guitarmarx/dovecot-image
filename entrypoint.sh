#!/bin/sh
set -e

# doku: https://wiki.dovecot.org/HowTo/DovecotOpenLdap

ldap_config="/etc/dovecot/dovecot-ldap.conf.ext"
sed -i "s|#hosts =|hosts = '$LDAP_HOST'|g" $ldap_config
sed -i "s|base =|base = '$LDAP_BASE'|g" $ldap_config
sed -i  "s|#user_filter.*|user_filter = $LDAP_FILTER|g" $ldap_config
sed -i  "s|#pass_filter.*|pass_filter = $LDAP_FILTER|g" $ldap_config


sed -i "s|#auth_bind_userdn =.*|auth_bind_userdn = $AUTH_BIND_USER_DN|g" $ldap_config
sed -i "s|#auth_bind =.*|auth_bind = $ENABLE_AUTH_BIND|g" $ldap_config
sed -i  "s|#dn =.*|dn = $LDAP_LOGIN_USER|g" $ldap_config
sed -i  "s|#dnpass =.*|dnpass = $LDAP_LOGIN_PASSWORD|g" $ldap_config


cp /srv/templates/dovecot.conf /etc/dovecot/dovecot.conf

#start dovecot
dovecot -F
