FROM ubuntu:bionic
LABEL maintainer="James Bowling <jbowling@vmware.com>" \
      version="1.0" \
      description="This creates an image with all the cli binaries used in a Enterprise PKS environment."

ENV BOSH_VERSION=6.0.0
ENV NOTARY_VERSION=0.6.1

WORKDIR /root

# Copy support files
COPY bosh ./bosh
COPY scripts ./scripts

# Setup needed repositories and install base dependencies
RUN chmod +x ./scripts/*.sh && ./scripts/setRepos.sh

# Install utilities
RUN ./scripts/installAwsCli.sh
RUN ./scripts/installAzureCli.sh
RUN ./scripts/installBoshcli.sh && \
    ./scripts/installOmCli.sh && \
    ./scripts/installNotary.sh && \
    ./scripts/installPKScli.sh && \
    ./scripts/installUaac.sh
RUN ./scripts/installGoogleSDK.sh
RUN ./scripts/installHelm.sh
RUN ./scripts/installKubectl.sh
RUN ./scripts/installVKE.sh

# Create Aliases
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc \
    && echo "alias k=kubectl" >> /.profile \
    && echo "alias p=pks" >> /.profile

# Expose ports for kube-proxy demo
EXPOSE 8001/tcp