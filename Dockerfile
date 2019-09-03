FROM ubuntu:bionic
LABEL maintainer="James Bowling <jbowling@vmware.com>" \
      version="1.0" \
      description="This creates an image with all the cli binaries used in a Enterprise PKS environment."

ENV BOSH_VERSION=6.0.0

WORKDIR /

# Copy support files
COPY scripts /root/scripts
RUN chmod +x /root/scripts/*.sh

# Setup needed repositories and install base dependencies
RUN /root/scripts/setRepos.sh

# Install utilities
RUN /root/scripts/installAwsCli.sh
RUN /root/scripts/installAzureCli.sh
RUN /root/scripts/installBoshcli.sh
RUN /root/scripts/installGoogleSDK.sh
RUN /root/scripts/installHelm.sh
#RUN /root/scripts/installIstioctl.sh
RUN /root/scripts/installKubectl.sh
RUN /root/scripts/installOmCli.sh
RUN /root/scripts/installPKScli.sh
RUN /root/scripts/installUaac.sh
RUN /root/scripts/installVKE.sh

#FROM buildpack-deps:bionic
#COPY --from=builder /usr/bin/* /usr/bin/
#COPY --from=builder /usr/local/bin/* /usr/local/bin/
COPY bosh /root/bosh

# Create Aliases
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc \
    && echo "alias k=kubectl" >> /root/.profile \
    && echo "alias p=pks" >> /root/.profile

# Expose ports for kube-proxy demo
EXPOSE 8001/tcp
