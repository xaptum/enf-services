FROM xaptum/enftun:1.1.0
MAINTAINER Xaptum

RUN apt-get update               && \
    apt-get install -y              \
        openssh-server           && \
    mkdir /run/sshd              && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22

VOLUME ["/data/keys"]

# Rename parent entrypoint
RUN mv /usr/local/bin/entrypoint.sh /usr/local/bin/enftun-entrypoint.sh && \
    ln -s usr/local/bin/enftun-entrypoint.sh # backwards compat


# Configure entrypoint script
COPY entrypoint.sh /usr/local/bin
RUN ln -sf usr/local/bin/entrypoint.sh /
ENTRYPOINT ["entrypoint.sh"]
