
dockerize -template /srv/templates/dovecot-sql.conf.tmpl:/etc/dovecot/dovecot-sql.conf


#start dovecot
dovecot -F