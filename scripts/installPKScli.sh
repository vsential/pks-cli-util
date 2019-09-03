# Install PKS CLI
echo "Installing PKS CLI" \
    && wget -q --no-check-certificate https://www.dropbox.com/s/4zm1216a89y5j78/pks-linux-amd64-1.5.0-build.291 \
    && mv pks-linux-amd64-1.5.0-build.291 /usr/local/bin/pks \
    && chmod +x /usr/local/bin/pks