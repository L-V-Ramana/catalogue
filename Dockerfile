# FROM node:20
# WORKDIR /opt/server
# COPY server.js /opt/server
# COPY *.json .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue" 
# CMD ["node","server.js"]


# FROM node:20-alpine3.22
# RUN addgroup -S Roboshop && adduser -S Roboshop -G Roboshop
# WORKDIR /opt/server
# COPY package.json /opt/server
# COPY server.js /opt/server
# RUN npm install 
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# USER Roboshop
# CMD ["/bin/node","/app/server.js"]

FROM node:20-alpine3.22 AS builder
WORKDIR /opt/server
COPY package.json /opt/server
COPY server.js /opt/server
RUN npm install 

FROM node:20-alpine3.22
WORKDIR /opt/server
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]
