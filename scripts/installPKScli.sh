# Install PKS CLI
echo "Installing PKS CLI" \
    && wget -q --no-check-certificate https://www.dropbox.com/s/ok6g2mxkiycudby/pks-linux-amd64-1.4.0-build.230 \
    && mv pks-linux-amd64-1.4.0-build.230 /usr/local/bin/pks \
    && chmod +x ./usr/local/bin/pks \
    && which pks \
    && pks --version