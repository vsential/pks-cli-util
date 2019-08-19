# Install Istio
echo "Installing Istioctl" \
    && wget -q https://s3-us-west-2.amazonaws.com/nsxsm/istio/linux/istioctl \
    && chmod +x ./istioctl \
    && mv istioctl /usr/local/bin/istioctl \
    && which istioctl \
    && istioctl version