# set folder permission
chown -R dovecot:dovecot  /var/vmail
chmod -R 770 /var/vmail

# set config
dockerize -no-overwrite -template /srv/templates/:/etc/dovecot/

#start dovecot
dovecot -F  2>&1 |  tee /var/log/dovecot.log