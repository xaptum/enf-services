### enf-apt-mirror

### Usage
```bash
docker run \
   --name=enf-apt \
   --detach=true \
   --restart=always \
   -p 81:81 \
   -v /path/to/cache:/var/nginx/cache
   enf-apt
```

### NOTES
```bash
docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -i -t enf-apt /bin/bash
```
