# Install Kubectl
echo "Installing Kubectl" \
    && apt-get -q install -y --no-install-recommends kubectl \
    && kubectl version --short --client