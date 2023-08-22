FROM centos:7
MAINTAINER anil nalawade

WORKDIR /var/www/html

RUN yum update -y 

RUN yum install -y httpd \
 zip \
 unzip sudo 

ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

RUN unzip photogenic.zip 
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip 
EXPOSE 80 22
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

