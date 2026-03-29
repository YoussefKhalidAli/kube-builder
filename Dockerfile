FROM ubuntu:24.04

RUN apt-get update

RUN apt-get install -y openssh-server systemd iproute2 nano && \
    mkdir -p /var/run/sshd

RUN echo "root:root" | chpasswd

COPY ansible_key /root/.ssh/id_rsa
COPY ansible_key.pub /root/.ssh/authorized_keys

RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/authorized_keys

RUN systemctl enable ssh

EXPOSE 22

CMD ["/lib/systemd/systemd"]