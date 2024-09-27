#all the dependencies and build the project

FROM node:16-alpine AS builder

USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json .
RUN npm install
COPY --chown=node:node . .

RUN npm run build

#setup the nginx image
FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html
