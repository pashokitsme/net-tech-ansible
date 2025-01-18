FROM alpine:latest

ARG PUBKEY_PATH

RUN apk update
RUN apk add --no-cache openssh python3

RUN mkdir -p /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  ssh-keygen -A

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
