FROM centos:latest
MAINTAINER anil nalawade

WORKDIR /var/www/html

RUN yum install -y httpd \
 zip \
 unzip

ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/ww/html/

RUN unzip photogenic.zip 
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip 
EXPOSE 80 22
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

