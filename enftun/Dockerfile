FROM debian:buster

MAINTAINER Xaptum

LABEL version="1.0"
LABEL description="Xaptum base image for access to the ENF"

ENV PROXY_URL http://cdn-fastly.deb.debian.org

# make Apt non-interactive
ARG DEBIAN_FRONTEND=noninteractive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90-docker      && \
    echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90-docker

# Make apt-key work in Docker
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
RUN sed -i "s%{GPG_EXE}\")' --%{GPG_EXE}\")' --batch --%g" /usr/bin/apt-key

# Install the Xaptum APT GPG key
RUN apt-get update  && \
    apt-get install -y --no-install-recommends      \
      gnupg                                         \
      dirmngr                                    && \
    apt-key adv --keyserver keyserver.ubuntu.com    \
                --recv-keys c615bfaa7fe1b4ca     && \
    apt-get remove -y                               \
      gnupg                                         \
      dirmngr                                    && \
    rm -rf /var/lib/apt/lists/*

# Install the Xaptum APT repo
COPY xaptum.list /etc/apt/sources.list.d/xaptum.list

# Install required packages
RUN apt-get update  && \
    apt-get install -y --no-install-recommends      \
      enftun                                        \
      ca-certificates                               \
      telnet netcat-openbsd wget curl               \
      iproute2                                   && \
    rm -rf /var/lib/apt/lists/*

# Install enftun configuration
COPY enf0.conf /etc/enftun/enf0.conf

# Configure entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/entrypoint.sh / # backwards compat
ENTRYPOINT ["entrypoint.sh"]
