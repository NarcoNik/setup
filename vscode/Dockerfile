FROM node:16 as builder
WORKDIR /app
COPY package.json /app/package.json
RUN npm install --force
COPY . /app
CMD [ "npm", "run", "start" ]
