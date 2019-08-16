FROM ubuntu:latest
LABEL maintainer="James Bowling <jbowling@vmware.com>" \
      version="1.0" \
      description="This creates an image with all the cli binaries used in a Enterprise PKS environment."

ENV BOSH_VERSION=6.0.0

WORKDIR /

# Install libraries
RUN echo "Configuring repos and updating package index" \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y apt-transport-https build-essential curl dnsutils git iputils-ping lsb-release mtr net-tools openssh-server \
    openssl python3 python3-dev python3-pip python3-setuptools ruby ruby-dev traceroute vim wget

# Install VKE
RUN echo "Installing VKE" \
    && wget -q https://s3.amazonaws.com/vke-cli-us-east-1/latest/linux64/vke \
    && chmod +x ./vke \
    && mv ./vke /usr/local/bin \
    && which vke \
    && vke --version

# Install Kubectl
RUN echo "Installing Kubectl" \
    && apt-get install -y kubectl \
    && kubectl version --short --client

# Install Istio
RUN echo "Installing Istioctl" \
    && wget -q https://s3-us-west-2.amazonaws.com/nsxsm/istio/linux/istioctl \
    && chmod +x ./istioctl \
    && mv istioctl /usr/local/bin/istioctl \
    && which istioctl \
    && istioctl version

# Install Helm
RUN echo "Installing Helm" \
    && curl -o get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get \
    && chmod +x ./get_helm.sh \
    && ./get_helm.sh \
    && rm ./get_helm.sh

# Install PKS CLI
RUN echo "Installing PKS CLI" \
    && wget -q --no-check-certificate https://www.dropbox.com/s/ok6g2mxkiycudby/pks-linux-amd64-1.4.0-build.230 \
    && mv pks-linux-amd64-1.4.0-build.230 /usr/local/bin/pks \
    && chmod +x ./usr/local/bin/pks \
    && which pks \
    && pks --version

# Install Cloud Foundry Bosh CLI
RUN echo "Installing Bosh CLI" \
    && wget -q https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 \
    && mv bosh-cli-${BOSH_VERSION}-linux-amd64 /usr/local/bin/bosh \
    && chmod +x ./usr/local/bin/bosh \
    && which bosh \
    && bosh --version

# Install Cloud Foundry UAAC
RUN echo "Installing uaac" \
  && gem install cf-uaac \
  && which uaac \
  && uaac --version

# Install Azure CLI
RUN echo "Installing Azure CLI" \
    && apt-get install azure-cli \
    && which az \
    && az --version

# Install Google Cloud SDK
RUN echo "Installing Google Cloud SDK" \
    && apt-get install -y google-cloud-sdk \
    && which gcloud \
    && gcloud version

# Create Aliases
RUN echo "alias k=kubectl" > /root/.profile

# Copy support files
COPY bosh /root/bosh

# Expose ports
EXPOSE 8001/tcp