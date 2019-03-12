dockerize -no-overwrite -template /srv/templates/:/etc/dovecot/

#start dovecot
dovecot -F  2>&1 |  tee /var/log/dovecot.log