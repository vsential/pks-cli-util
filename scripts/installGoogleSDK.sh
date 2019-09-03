# Install Google Cloud SDK
echo "Installing Google Cloud SDK" \
    && apt-get install -q -y google-cloud-sdk \
    && which gcloud \
    && gcloud version