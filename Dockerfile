FROM alpine

RUN apk add --no-cache openssh openssh-server

RUN rm -f /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_ed25519_key

RUN passwd root -d

COPY sshd_config /etc/ssh/sshd_config

CMD [ "/usr/sbin/sshd",  "-D", "-e" ]
