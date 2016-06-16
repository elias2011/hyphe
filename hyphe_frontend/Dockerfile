FROM nginx:latest
COPY ./app /usr/share/nginx/html
COPY ./docker-nginx-vhost.conf /etc/nginx/conf.d/default.conf 
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
#RUN /bin/cp /usr/share/nginx/html/conf/conf_default.js /usr/share/nginx/html/conf/conf.js
#RUN sed --in-place "s|/##WEBPATH##|//' + window.location.hostname + ':' + window.location.port + '/hyphe|" /usr/share/nginx/html/conf/conf.js

#RUN sed --in-place "s|'serverURL'\s*,.*|'serverURL', '/+ window.location.hostname + ':' + window.location.port + $HYPHE_API_URI')|" /usr/share/nginx/html/conf/conf.js
#RUN sed --in-place "s|'googleAnalyticsId'\s*,.*|'googleAnalyticsId', '${HYPHE_GOOGLE_ANALYTICS_ID}')|" /usr/share/nginx/html/conf/conf.js

#RUN sed --in-place "s|\(\'disclaimer\'\s*,.s*\'.*\'\)|\(\'disclaimer\'\s*,.s*\'${HYPHE_DISCLAIMER}\'\)|" /usr/share/nginx/html/conf/conf.js
CMD ["nginx", "-g", "daemon off;"]
