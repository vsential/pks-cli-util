# Install Operations Manager CLI
echo "Installing om cli" \
    && apt-get install -q -y --no-install-recommends om \
    && which om \
    && om --version