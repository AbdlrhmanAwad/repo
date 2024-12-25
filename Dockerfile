FROM nginx:latest #this is the base image
COPY index.html /usr/share/nginx/html
EXPOSE 80
