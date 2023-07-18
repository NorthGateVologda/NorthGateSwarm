# Старайтесь всегда виксировать версию!
# Через месяц в latest могут внести такие изменения, коорые погубят всё
# приложение и мы можем потратить очень много времени на поиск причины
FROM node:20.4.0

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# Для этого целесообразно всё же вернуть данный Dockerfile в репозиторий
# проекта frontend
#COPY . ./

CMD ["npm", "run", "start-build"]
