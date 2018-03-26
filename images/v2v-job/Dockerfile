FROM fedora:26


RUN dnf install -y virt-v2v libxslt jq origin-clients && dnf clean all
RUN curl -L http://download.libguestfs.org/binaries/appliance/appliance-1.36.1.tar.xz | tar -C /usr/lib64/guestfs -xJf -

ENV LIBGUESTFS_BACKEND=direct
ENV LIBGUESTFS_PATH=/usr/lib64/guestfs/appliance

WORKDIR /v2v.d
ENTRYPOINT ["/v2v.d/bin/job"]

ADD . /v2v.d/
