FROM fedora:26

RUN dnf install -y nmap-ncat

ENTRYPOINT /usr/bin/nc -s 0.0.0.0 --listen --wait 60 54321 > /dst/disk.raw
