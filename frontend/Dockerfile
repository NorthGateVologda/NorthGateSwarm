FROM node:latest

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# Для этого целесообразно всё же вернуть данный Dockerfile в репозиторий
# проекта frontend
#COPY . ./

CMD ["npm", "run", "start-build"]
