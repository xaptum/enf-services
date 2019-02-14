FROM nginx:1.15.8

MAINTAINER Xaptum

LABEL version="1.1"
LABEL description="Nginx Proxy Image"

ARG DEBIAN_FRONTEND=noninteractive

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90circleci \
  && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90circleci \
	&& sed -i "s%{GPG_EXE}\")' --%{GPG_EXE}\")' --batch --%g" /usr/bin/apt-key

# Copy nginx proxy files
ADD nginx.conf /etc/nginx/nginx.conf
ADD proxy.conf /etc/nginx/proxy.conf
ADD cacher.conf /etc/nginx/conf.d/cacher.conf

RUN rm /etc/nginx/conf.d/default.conf && \
	mkdir -p /var/nginx/conf && \
	chown -R nginx:nginx /var/nginx

# Install dirmngr and gnugpg
RUN apt-get update  && \
    apt-get install -y --no-install-recommends \
    gnupg                                      \
    dirmngr

# Install base packages
RUN apt-get update  && \
	apt-get install -y --no-install-recommends \
	apt-utils                                  \
	curl                                       \
	openssh-client                             \
	wget                                       \
	make                                       \
	g++                                        \
	sudo                                       \
	cmake                                      \
	ninja-build                                \
	unzip                                      \
	bzip2                                   && \
	rm -rf /var/lib/apt/lists/*

# call entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/entrypoint.sh / # backwards compat
ENTRYPOINT ["entrypoint.sh"]

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
