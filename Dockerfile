FROM node:16-slim
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
RUN npm run build
COPY . ./
CMD [ "node", "main.js" ]