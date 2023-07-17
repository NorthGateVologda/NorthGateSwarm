# Создём сеть, если она не существует
sudo docker network create --driver overlay --attachable northgatevologda

# Запускаем в определенном порядке все
sudo docker stack deploy --compose-file nginx/docker-compose.yml nginxstack
sudo docker stack deploy --compose-file postgres/docker-compose.yml dbstack
sudo docker stack deploy --compose-file backend/docker-compose.yml backendstack
sudo docker stack deploy --compose-file frontend/docker-compose.yml frontendstack
