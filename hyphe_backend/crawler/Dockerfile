FROM python:2.7

RUN apt-get update 

RUN pip install service_identity==14 \
  && pip install cffi \
  && pip install cryptography \
  && pip install pyOpenSSL \
  && pip install ndg-httpsclient \
  && pip install pyasn1 \
  && pip install pymongo==2.7 \
  && pip install txmongo==0.6 \
  && pip install selenium==2.42.1 \
  && pip install urllib3[secure] \
  && pip install Scrapy==0.24.6 \
  && pip install scrapyd==1.0.1

EXPOSE 6800

VOLUME ["/var/lib/scrapyd"]
VOLUME ["/var/log/scrapyd"]

CMD ["scrapyd"]
