FROM ubuntu

RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

COPY main.js /main.js
COPY package.json /package.json
COPY package-lock.json /package-lock.json

RUN npm install

ENTRYPOINT ["node", "main.js"]
