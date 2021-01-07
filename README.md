# insecure openssh server for port forwarding  via stdio

[ngyuki/insecure-sshd - Docker Hub](https://hub.docker.com/repository/docker/ngyuki/insecure-sshd/general)

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

```sh
# console 1
nc -lkv 5000

# console 2
docker-compose up

# console 3
ssh root@localhost -C -N -g \
  -o ProxyCommand='docker-compose exec -T fwd nc localhost 22' \
  -o ExitOnForwardFailure=yes \
  -o PermitLocalCommand=yes \
  -o LocalCommand='echo ok' \
  -o StrictHostKeyChecking=no \
  -R 5000:localhost:5000

# console 4
docker-compose exec app nc -v fwd 5000
```
