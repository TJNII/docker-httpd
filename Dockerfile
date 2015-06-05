FROM debian:jessie
MAINTAINER Tom Noonan II <tom@tjnii.com>

RUN apt-get update

# Install Apache
RUN apt-get install -y apache2

# Drop in a basic index page
COPY files/var/www /var/www

# Run Apache in the foreground
CMD apachectl -f /etc/apache2/apache2.conf -e info -DFOREGROUND
