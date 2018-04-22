FROM httpd:latest
MAINTAINER bostrt@gmail.com

RUN echo Include conf/extras/auth-proxy.conf >> /usr/local/apache2/conf/httpd.conf

ADD htpasswd /usr/local/apache2/conf/htpasswd
ADD auth-proxy.conf /usr/local/apache2/conf/extras/auth-proxy.conf

EXPOSE 80 443

