FROM ubuntu:latest
LABEL maintainer="James Bowling <jbowling@vmware.com>" \
      version="1.0" \
      description="This creates an image with all the cli binaries used in a Enterprise PKS environment."

ENV BOSH_VERSION=6.0.0

WORKDIR /

# Copy support files
COPY bosh /root/bosh
COPY scripts /root/scripts
RUN chmod +x /root/scripts/*.sh

# Setup needed repositories and install base dependencies
RUN /root/scripts/setRepos.sh

# Install utilities
RUN /root/scripts/installUtilities.sh

# Create Aliases
RUN echo "alias k=kubectl" >> /root/.profile
RUN echo "alias p=pks" >> /root/.profile

# Expose ports
EXPOSE 8001/tcp