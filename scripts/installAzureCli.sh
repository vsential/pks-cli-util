# Install Azure CLI
echo "Installing Azure CLI" \
    && apt-get install -q -y azure-cli \
    && which az \
    && az --version