# FROM node:10-alpine
# FROM node:8.15.1-alpine
FROM node:8.15.1-alpine as builder
ENV NPM_CONFIG_LOGLEVEL warn
ARG VERSION=0.20
RUN deluser --remove-home node && \
    addgroup -g 1000 composer && \
    adduser -u 1000 -G composer -s /bin/sh -D composer && \
    apk add --no-cache make gcc g++ python git libc6-compat python2 python2-dev && \
    su -c "npm config set prefix '/home/composer/.npm-global'" - composer && \
    su -c "npm install --production -g pm2@4.4.0 composer-cli@${VERSION} composer-rest-server@${VERSION} loopback-connector-couchdb composer-wallet-redis composer-wallet-cloudant composer-wallet-ibmcos" - composer && \
    su -c "npm cache clean --force" - composer && \
    rm -rf /home/composer/.config /home/composer/.node-gyp /home/composer/.npm && \
    apk del make gcc g++ python git

# Run as the composer user ID.
FROM node:10.24.1-alpine
ENV NPM_CONFIG_LOGLEVEL warn
ARG VERSION=0.19.20
RUN deluser --remove-home node && \
    addgroup -g 1000 composer && \
    adduser -u 1000 -G composer -s /bin/sh -D composer  && \
    su -c "npm config set prefix '/home/composer/.npm-global'" - composer
COPY --from=builder --chown=composer:composer /home/composer /home/composer

WORKDIR /home/composer


RUN su -c "mkdir -p /home/composer/.composer" - composer
VOLUME [ "/home/composer/.composer" ]
COPY --chown=composer:composer ./crypto-config/PeerAdmin@hlfv1.card /home/composer/.composer/card/PeerAdmin@hlfv1.card
RUN su -c "chown -R composer:composer /home/composer"
RUN su -c "chmod -R 775 /home/composer"

RUN ls -la

USER composer

# Add global composer modules to the path.
ENV PATH /home/composer/.npm-global/bin:$PATH

RUN ls -la /home/composer/.npm-global/bin

# Run in the composer users home directory.
CMD [ "pm2-docker", "composer-rest-server" ]
# ENTRYPOINT [ "ls", "-la", "." ]

# Expose port 3000.
EXPOSE 3000