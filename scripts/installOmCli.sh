# Install Operations Manager CLI
echo "Installing om cli" \
    && apt-get install -q -y om \
    && which om \
    && om --version