# Install VKE
echo "Installing VKE" \
    && wget -q https://s3.amazonaws.com/vke-cli-us-east-1/latest/linux64/vke \
    && chmod +x ./vke \
    && mv ./vke /usr/local/bin