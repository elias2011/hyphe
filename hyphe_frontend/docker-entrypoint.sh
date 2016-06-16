#!/bin/bash -eu


/bin/cp /usr/share/nginx/html/conf/conf_default.js /usr/share/nginx/html/conf/conf.js
#RUN sed --in-place "s|/##WEBPATH##|//' + window.location.hostname + ':' + window.location.port + '/hyphe|" /usr/share/nginx/html/conf/conf.js

[[ -v HYPHE_API_URI ]] && sed --in-place "s|'serverURL'\s*,.*|'serverURL', '//' + window.location.hostname + ':' + window.location.port + '/api/')|" /usr/share/nginx/html/conf/conf.js
[[ -v HYPHE_GOOGLE_ANALYTICS_ID ]] && sed --in-place "s|'googleAnalyticsId'\s*,.*|'googleAnalyticsId', '${HYPHE_GOOGLE_ANALYTICS_ID}')|" /usr/share/nginx/html/conf/conf.js
[[ -v HYPHE_DISCLAIMER ]] && sed --in-place "s|'disclaimer'\s*,.*|'disclaimer', '${HYPHE_DISCLAIMER}')|" /usr/share/nginx/html/conf/conf.js

exec "$@"
