#--->THIS IS BASE IMAGE (BUILDING BLOCK)
FROM NGINX:LATEST
COPY . /HOME/VAR/WWW/HTML
#THIS MEANS GO COPY THE CONFIGURATION FROM THIS PATH INTO THIS FILE TO RUN THIS IMAGE
