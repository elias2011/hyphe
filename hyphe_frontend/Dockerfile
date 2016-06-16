FROM nginx:latest
COPY ./app /usr/share/nginx/html
COPY ./docker-nginx-vhost.conf /etc/nginx/conf.d/default.conf 
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
