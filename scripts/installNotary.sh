echo "Installing notary" \
    && wget -q https://github.com/theupdateframework/notary/releases/download/v${NOTARY_VERSION}/notary-Linux-amd64 \
    && chmod +x notary-Linux-amd64 \
    && mv notary-Linux-amd64 /usr/local/bin/notary
