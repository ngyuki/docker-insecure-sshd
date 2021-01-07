# insecure openssh server for port forwarding  via stdio

## Demo

[![asciicast](https://asciinema.org/a/Wxe9vptDncILTtI3VkCMrLzBt.svg)](https://asciinema.org/a/Wxe9vptDncILTtI3VkCMrLzBt)

## Usage

```yaml
# docker-compose.yml
version: "3.7"
services:
  fwd:
    image: ngyuki/insecure-sshd
  app:
    image: alpine
    command: [ tail, -f, /dev/null ]
```

```
# console 1
nc -lkv 5000

# console 2
docker-compose up

# console 3
ssh -o ProxyCommand='docker-compose exec -T fwd nc localhost 22' \
    -o StrictHostKeyChecking=no \
    -R 5000:localhost:5000 -N -g root@localhost

# console 4
docker-compose exec app nc -v fwd 5000
```
