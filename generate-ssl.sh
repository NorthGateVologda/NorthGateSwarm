# Создаём директории
sudo mkdir /home/docker_volumes/
sudo mkdir /home/docker_volumes/certs/

# Создаём сертификат
sudo openssl genrsa -out /home/docker_volumes/certs/server.key 2048
sudo openssl req -new -key /home/docker_volumes/certs/server.key -out /home/docker_volumes/certs/server.csr
sudo openssl x509 -req -days 365 -in /home/docker_volumes/certs/server.csr -signkey /home/docker_volumes/certs/server.key -out /home/docker_volumes/certs/server.crt

# Выдаём права
sudo chown -R 5050:5050 /home/docker_volumes/certs/