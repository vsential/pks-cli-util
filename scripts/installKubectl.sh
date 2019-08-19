# Install Kubectl
echo "Installing Kubectl" \
    && apt-get -q install -y kubectl \
    && kubectl version --short --client