FROM ubuntu:22.04

# Install SSH client and ufw
RUN apt-get update && \
    apt-get install -y openssh-client ufw iptables sudo
WORKDIR /targethost
COPY targethost.pem /targethost
COPY known_hosts /root/.ssh/known_hosts
COPY config /root/.ssh/config
RUN chmod 400 /targethost/targethost.pem

# Configure SSH tunnel on container start
CMD ["bash", "-c", "ssh -D 0.0.0.0:8888 -N -C ubuntu@targethost -o ProxyJump=targethost"] 
