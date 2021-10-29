# Dovecot-Image

this docker image uses dovecot to provide a basic imap server connected to ldap
## Quickstart

#### Build Image
```sh
git clone https://github.com/guitarmarx/dovecot-image.git
cd perdition-image
docker build -t dovecot .
```
#### Run Container
```sh
docker run -d \
        -p 143:143 \
        -e LDAP_HOST=<host> \
        -e LDAP_BASE=ou=group,dc=domain,dc=net \
        -v <your-path>:/var/vmail/mailboxes \
        --name dovecot
```



