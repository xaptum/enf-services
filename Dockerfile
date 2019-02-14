FROM nginx:1.15.8

MAINTAINER Xaptum

LABEL version="1.1"
LABEL description="Nginx Proxy Image"

ADD nginx.conf /etc/nginx/nginx.conf
ADD proxy.conf /etc/nginx/proxy.conf

ADD cacher.conf /etc/nginx/conf.d/cacher.conf

RUN rm /etc/nginx/conf.d/default.conf && \
	mkdir -p /var/nginx/conf && \
	chown -R nginx:nginx /var/nginx

EXPOSE 81
