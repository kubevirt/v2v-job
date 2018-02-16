FROM fedora:26


RUN dnf install -y virt-v2v libxslt jq nmap-ncat wdfs && dnf clean all
RUN curl -L http://download.libguestfs.org/binaries/appliance/appliance-1.36.1.tar.xz | tar -C /usr/lib64/guestfs -xJf -
RUN curl -LO \
  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod a+x kubectl \
  && mv -v kubectl /usr/local/bin/kubectl

ENV LIBGUESTFS_BACKEND=direct
ENV LIBGUESTFS_PATH=/usr/lib64/guestfs/appliance
