# FROM node:10-alpine
# FROM node:8.15.1-alpine
FROM composer-rest-server-builder as builder
# RUN ls -la

FROM node:10.24.1
# Expose port 3000.
EXPOSE 3000

RUN apt-get update && apt-get install -y build-essential python git python-dev

RUN deluser --remove-home node
RUN addgroup --gid 1000 composer
RUN useradd --uid 1000 -m --gid 1000 --shell /bin/bash composer
# RUN usermod -aG composer composer
RUN mkdir -p /home/composer/server
RUN chown -R composer:composer /home/composer
RUN chmod -R 775 /home/composer
RUN su -c "npm config set prefix '/home/composer/.npm-global'" - composer

USER composer
RUN mkdir /home/composer/.composer
WORKDIR /home/composer/server
COPY --from=builder --chown=1000:1000 /usr/app /home/composer/server
# COPY . .
# RUN npm install
# RUN npm i loopback-connector-couchdb composer-wallet-redis composer-wallet-cloudant composer-wallet-ibmcos
# RUN npm install -g composer-cli@0.20.9
RUN cd /home/composer/server/node_modules/fabric-client && npm i grpc@1.24.2
RUN rm -rf /home/composer/server/node_modules/fabric-client/node_modules/grpc
COPY --chown=1000:1000 ./PeerAdmin@hlfv1.card /home/composer/.composer/cards/PeerAdmin@hlfv1.card
RUN cd /home/composer/.composer/cards/ && mkdir PeerAdmin@hlfv1 && unzip PeerAdmin@hlfv1.card -d ./PeerAdmin@hlfv1 && ls -la ./PeerAdmin@hlfv1


CMD ["cli.js", "-c", "PeerAdmin@hlfv1", "-n", "never", "-u", "false", "-w", "true" ]
# RUN ls -la

# RUN su -c "npm config set prefix '/home/composer/.npm-global'" - composer && \
#     su -c "npm install --production -g pm2@4.4.0" - composer


# ENV PATH /home/composer/.npm-global/bin:$PATH

# # # Run in the composer users home directory.
# # # ENTRYPOINT [ "ls", "-la", "." ]
