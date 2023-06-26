FROM node:16-slim
WORKDIR /usr/src/app
COPY *.json ./
RUN npm config set registry https://mirrors.cloud.tencent.com/npm/
RUN npm install -g npm
RUN npm install
RUN ls
RUN npm run build
COPY . ./
CMD [ "node", "main.js" ]