FROM xaptum/enftun:1.0.0

RUN apt-get update     && \
    apt-get install -y    \
        python3

COPY xdemo_target_servers /usr/local/bin
COPY sierra_wireless.2332.txt /usr/local/share/xaptum/
COPY xaptum_demo.8080.txt /usr/local/share/xaptum/

COPY start_targets.sh /usr/local/bin/
RUN ln -s usr/local/bin/start_targets.sh / # backwards compat

CMD ["/usr/local/bin/start_targets.sh"]
