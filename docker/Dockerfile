FROM node:current-alpine3.19

WORKDIR /myportfolio

COPY app/package*.json .

RUN npm install

COPY app .

EXPOSE 3000

CMD ["npm", "start"]