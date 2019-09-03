# Install Cloud Foundry Bosh CLI
echo "Installing Bosh CLI" \
    && wget -q https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 \
    && mv bosh-cli-${BOSH_VERSION}-linux-amd64 /usr/local/bin/bosh \
    && chmod +x ./usr/local/bin/bosh