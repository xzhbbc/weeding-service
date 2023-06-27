# 二开推荐阅读[如何提高项目构建效率](https://developers.weixin.qq.com/miniprogram/dev/wxcloudrun/src/scene/build/speed.html)
FROM alpine:3.13

# 容器默认时区为UTC，如需使用上海时间请启用以下时区设置命令
# RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# 使用 HTTPS 协议访问容器云调用证书安装
RUN apk add ca-certificates
#RUN apk add g++ make python

# 安装依赖包，如需其他依赖包，请到alpine依赖包管理(https://pkgs.alpinelinux.org/packages?name=php8*imagick*&branch=v3.13)查找。
# 选用国内镜像源以提高下载速度
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencent.com/g' /etc/apk/repositories \
  && apk add --update --no-cache nodejs npm
WORKDIR /app
COPY *.json /app/
COPY .env /app/
RUN npm config set registry https://mirrors.cloud.tencent.com/npm/
#RUN npm install --global --production windows-build-tools
#RUN npm install -g npm
RUN apk add --no-cache --virtual .build-deps make gcc g++ python \
  && npm install --production --silent \
  && apk del .build-deps
RUN ls
RUN npm run build
RUN mkdir /app/logs
RUN mkdir /app/logs/error.log
COPY . /app
CMD ["node", "/dist/main.js"]