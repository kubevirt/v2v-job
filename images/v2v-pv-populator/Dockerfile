FROM fedora:26

RUN dnf install -y nmap-ncat

ENTRYPOINT /usr/bin/nc -v --listen --wait 60 54321 > /dst/disk.raw
