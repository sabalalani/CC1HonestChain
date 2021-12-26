FROM node:8.15.1
WORKDIR /usr/app
COPY . .
RUN apt-get update && apt-get install -y build-essential python git python-dev
RUN npm install
RUN npm i loopback-connector-couchdb composer-wallet-redis composer-wallet-cloudant composer-wallet-ibmcos