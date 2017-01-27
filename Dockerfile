FROM xmlangel/base-ubuntu14.04
EXPOSE 80
COPY file /root
RUN apt-get update && apt-get install -y apache2
CMD /usr/sbin/apache2ctl -D FOREGROUND
