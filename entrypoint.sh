#!/bin/sh
set -e

# doku: https://wiki.dovecot.org/HowTo/DovecotOpenLdap

# modify ldap config
ldap_config="/etc/dovecot/dovecot-ldap.conf.ext"
sed -i "s|#hosts =|hosts = '$LDAP_HOST'|g" $ldap_config
sed -i "s|base =|base = '$LDAP_BASE'|g" $ldap_config
sed -i  "s|#user_filter.*|user_filter = $LDAP_FILTER|g" $ldap_config
sed -i  "s|#pass_filter.*|pass_filter = $LDAP_FILTER|g" $ldap_config


sed -i "s|#auth_bind_userdn =.*|auth_bind_userdn = $AUTH_BIND_USER_DN|g" $ldap_config
sed -i "s|#auth_bind =.*|auth_bind = $ENABLE_AUTH_BIND|g" $ldap_config
sed -i  "s|#dn =.*|dn = $LDAP_LOGIN_USER|g" $ldap_config
sed -i  "s|#dnpass =.*|dnpass = $LDAP_LOGIN_PASSWORD|g" $ldap_config

# modifly dovecot config
dovecot_config="/etc/dovecot/dovecot-ldap.conf.ext"
cp /srv/templates/dovecot.conf $dovecot_config

sed -i  "s|ssl = yes|ssl = $ENABLE_SSL|g" $dovecot_config
sed -i  "s|ssl_key =.*|ssl_key = <$SSL_KEY_FILE|g" $dovecot_config
sed -i  "s|ssl_cert =.*|ssl_cert = <$SSL_CERT_FILE|g" $dovecot_config
sed -i  "s|ssl = yes|ssl = $ENABLE_SSL|g" $dovecot_config

chown -R $UID:$GID /var/mail
chmod 775 /var/mail

#start dovecot
dovecot -F &
sleep 2
tail -f /var/log/*
