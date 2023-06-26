FROM node:16-slim
WORKDIR /app
COPY *.json ./
COPY .env ./
RUN npm config set registry https://mirrors.cloud.tencent.com/npm/
RUN npm install -g npm
RUN npm install
RUN ls
RUN npm run build
RUN mkdir logs
RUN mkdir logs/error.log
COPY . ./
CMD node /app/dist/main.js