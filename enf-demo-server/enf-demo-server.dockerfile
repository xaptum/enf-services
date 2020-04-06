FROM xaptum/enftun

RUN apt-get update     && \
    apt-get install -y    \
        python3

COPY xdemo_target_servers /usr/local/bin
COPY sierra_wireless.2332.txt /usr/local/share/xaptum/

CMD ["/usr/local/bin/xdemo_target_servers", "/usr/local/share/xaptum/", "/var/log/xaptum/xdemo_target_servers.log"]
