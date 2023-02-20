# Secure Coding Project

Backup project: dockerize the application and create a container responsible for backing up the database, encrypting the backup and upload it somewhere.

## Pre-requisite

Run init.sh

On sftp & postgres container, add this line to the /etc/ssh/sshd_config, add this line to the document
PermitRootLogin yes
Set the root password with this command
passwd root root
Restart the ssh service for the changes to take effect.
service ssh restart

On backup_services
You may have to change the IP addresses of the postgres server and the sftp server due to DHCP policy.
You should first establish a SSH connection from back_services to the postgres and sftp container in order for them to add this container to their known host list.
If you have trouble with "Host key verification failed" error, please empty the known host list file from /root/.ssh on the target (postgres/sftp) or with `ssh-keygen -R <HOST_IP>`

## Creating the app docker image

Ideally, this part would be part of the CI/CD cycle where the image is built at the end of a dev. cycle and pushed to a repo.
In app folder with docker file in it `docker build -t secure-coding-app .`

## Good practices that should be enforced out of this POC

Use public key authentification for ssh/sftp as it is far more secure than just passing a password from a file to a command.
Here the sftp server is just a container, please use a remote host as another server or a s3 instance.
Here we use the script postgres.sh to backup the dabatase. This action should be automated as a cron job to backup on a regular basis.

## Problem to fix

-   Add incremental backups covering small downtime
-   Too much disk I/O with pg_dump/gpg ; pipe to backup_servicers the compressed result of pg_dump via SSL and gpg it on backup_services.
-   Credentials on a separate volume with 25 char.
-   Make Dockerfile for custom images instead of using an init.sh
