# Install VKE
echo "Installing VKE" \
    && wget -q https://s3.amazonaws.com/vke-cli-us-east-1/latest/linux64/vke \
    && chmod +x ./vke \
    && mv ./vke /usr/local/bin \
    && which vke \
    && vke --version

# Install Kubectl
echo "Installing Kubectl" \
    && apt-get -q install -y kubectl \
    && kubectl version --short --client

# Install Istio
echo "Installing Istioctl" \
    && wget -q https://s3-us-west-2.amazonaws.com/nsxsm/istio/linux/istioctl \
    && chmod +x ./istioctl \
    && mv istioctl /usr/local/bin/istioctl \
    && which istioctl \
    && istioctl version

# Install Helm
echo "Installing Helm" \
    && curl -s -o get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get \
    && chmod +x ./get_helm.sh \
    && ./get_helm.sh \
    && rm ./get_helm.sh

# Install PKS CLI
echo "Installing PKS CLI" \
    && wget -q --no-check-certificate https://www.dropbox.com/s/ok6g2mxkiycudby/pks-linux-amd64-1.4.0-build.230 \
    && mv pks-linux-amd64-1.4.0-build.230 /usr/local/bin/pks \
    && chmod +x ./usr/local/bin/pks \
    && which pks \
    && pks --version

# Install Cloud Foundry Bosh CLI
echo "Installing Bosh CLI" \
    && wget -q https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 \
    && mv bosh-cli-${BOSH_VERSION}-linux-amd64 /usr/local/bin/bosh \
    && chmod +x ./usr/local/bin/bosh \
    && which bosh \
    && bosh --version

# Install Cloud Foundry UAAC
echo "Installing uaac" \
    && gem install cf-uaac \
    && which uaac \
    && uaac --version

# Install Operations Manager CLI
echo "Installing om cli" \
    && apt-get install -q -y om \
    && which om \
    && om --version
    
# Install Azure CLI
echo "Installing Azure CLI" \
    && apt-get install -q -y azure-cli \
    && which az \
    && az --version

# Install Google Cloud SDK
echo "Installing Google Cloud SDK" \
    && apt-get install -q -y google-cloud-sdk \
    && which gcloud \
    && gcloud version