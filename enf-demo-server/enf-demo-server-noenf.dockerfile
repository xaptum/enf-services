FROM debian:stretch

RUN apt-get update     && \
    apt-get install -y    \
        python3

COPY xdemo_target_servers /usr/local/bin
COPY sierra_wireless.2332.txt /usr/local/share/xaptum/
COPY xaptum_demo.8080.txt /usr/local/share/xaptum/

EXPOSE 2332
EXPOSE 8080

CMD ["/usr/local/bin/xdemo_target_servers", "/usr/local/share/xaptum/", "/var/log/xaptum/xdemo_target_servers.log"]
