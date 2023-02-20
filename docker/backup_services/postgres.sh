sshpass -f ssh_pwd ssh root@192.168.80.4 "cd /var/lib/postgresql/data/backups && pg_dump iam -U tutorial --file=/var/lib/postgresql/data/backups/iam_db-$(date +%d-%m-%y).sql && gpg --batch --passphrase-file gpg_pwd -c iam_db-$(date +%d-%m-%y).sql"
sshpass -f ssh_pwd sftp root@192.168.80.4 << EOF
cd /var/lib/postgresql/data/backups
get iam_db-$(date +%d-%m-%y).sql.gpg
rm iam_db-$(date +%d-%m-%y).sql
rm iam_db-$(date +%d-%m-%y).sql.gpg
exit
EOF
sshpass -f ssh_pwd sftp root@192.168.80.3 << EOF
cd /backups
put iam_db-$(date +%d-%m-%y).sql.gpg
exit
EOF
rm iam_db-$(date +%d-%m-%y).sql.gpg
