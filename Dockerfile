FROM buildkite/puppeteer:latest
LABEL org.opencontainers.image.source https://github.com/ccjmne/puppeteer-html2pdf

# https://github.com/Yelp/dumb-init
RUN apt-get update && apt-get install -y dumb-init

WORKDIR /app/build
ADD . .
RUN npm install -y && npm run build

WORKDIR /app
RUN mv /app/build/dist/server.js .

EXPOSE 3000

ENTRYPOINT ["dumb-init", "--"]

CMD ["node", "-e", "require('./server.js').use(require('puppeteer'))"]
