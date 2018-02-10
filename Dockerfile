FROM fedora:26


RUN dnf install -y virt-v2v kubernetes-client && dnf clean all
RUN curl -L http://download.libguestfs.org/binaries/appliance/appliance-1.36.1.tar.xz | tar -C /usr/lib64/guestfs -xJf -

ADD . /v2v.d/

ENV LIBGUESTFS_BACKEND=direct
ENV LIBGUESTFS_PATH=/usr/lib64/guestfs/appliance
CMD cd /v2v.d/ && bash -x job /v2v-src /v2v-dst
