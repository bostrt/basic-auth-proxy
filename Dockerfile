FROM fedora:latest
MAINTAINER bostrt@gmail.com

RUN dnf install -y \
    httpd \
    mod_ssl \
    openssl && \
    dnf clean all

#RUN mkdir /usr/local/apache2/secret
RUN mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.disable
RUN rm -rf /run/httpd && mkdir /run/httpd && chmod -R a+rwx /run/httpd
RUN mkdir /etc/httpd/secret && chmod -R a+rwx /etc/httpd/secret

ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD auth-proxy.conf /etc/httpd/conf.d/auth-proxy.conf
ADD startup.sh /usr/local/bin/

VOLUME /etc/httpd/secret

EXPOSE 8080

USER 1001

CMD ["startup.sh"]
