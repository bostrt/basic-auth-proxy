FROM httpd:latest
MAINTAINER bostrt@gmail.com

RUN echo Include conf/extras/auth-proxy.conf >> /usr/local/apache2/conf/httpd.conf
RUN mkdir /usr/local/apache2/secret

#ADD htpasswd /usr/local/apache2/secret/htpasswd
ADD auth-proxy.conf /usr/local/apache2/conf/extras/auth-proxy.conf
ADD startup.sh /usr/local/bin/

VOLUME /usr/local/apache2/secret/

EXPOSE 80 443

CMD ["startup.sh"]
