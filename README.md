# Dovecot-Image

this docker image uses dovecot to provide a basic imap server.
This image depends on a running mysql image to store the unser login informations.

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
        -e DB_HOST=<database-server> \
        -e DB_USER=dovecot \
        -e DB_PASS=dovecot \
        -e DB_NAME=dovecot \
        -v <your-path>:/var/vmail/mailboxes \
        --name dovecot
```


# Basic Configuraion Parameters
Parameter | Function| Default Value|
---|---|---|
DB_HOST|database host|-
DB_NAME| database name|dovecot
DB_USER|database user|dovecot
DB_PASS|database password|dovecot

# Add User to Dovecot
1. Generate a SHA-512 Password with the following command inside the dovecot container:
    ```sh
    doveadm pw -s  SHA512-CRYPT -p <password>
    ````
2. Add the user to the database with the following sql statement:
    ```sql
    Insert into users (user,password,active) VALUES('user@domain.de','<password-hash>','Y');
    ````







