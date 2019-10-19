# set folder permission
chown -R dovecot:dovecot  /var/vmail
chmod -R 770 /var/vmail

# create table
dockerize -wait tcp://$DB_HOST:$DB_PORT -timeout 60s
echo "create tables ..."
mysql -h $DB_HOST -u $DB_USER --password=$DB_PASS $DB_NAME < /srv/templates/create_tables.sql

# set config
dockerize -no-overwrite -template /srv/templates/:/etc/dovecot/

#start dovecot
dovecot -F  2>&1 |  tee /var/log/dovecot.log