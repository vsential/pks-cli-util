# Install Helm
echo "Installing Helm" \
    && curl -s -o get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get \
    && chmod +x ./get_helm.sh \
    && ./get_helm.sh \
    && rm ./get_helm.sh