FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# In docker environment it only let dockers to communicate among each
# other but in elastic beanstalk story is diffrent bcz it read the docker file
# and after checking the expose directive , it map the port to elastic beanstalk .

COPY --from=builder /app/build /usr/share/nginx/html