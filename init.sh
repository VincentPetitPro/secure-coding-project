docker compose up -d
sleep 10
docker-compose exec -it debian sh -c "apt update && apt install -y postgresql-client && apt install -y sshpass"
docker-compose exec -it sftp sh -c "apt update && apt install -y openssh-server"
docker-compose exec -it postgres sh -c "apt update && apt install -y openssh-server"