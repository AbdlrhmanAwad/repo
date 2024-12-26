FROM nginx:latest 
#this is the base image
#we can type WORKDIR /DIR NAME 	tthis means this is the working dir
#after workdir write copy . . this means compy all files in this file
COPY index.html /usr/share/nginx/html
EXPOSE 80  
#this is the port


#ENV node_env production > this is variable named production
 
