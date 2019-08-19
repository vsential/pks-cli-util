# Install Cloud Foundry UAAC
echo "Installing uaac" \
    && gem install cf-uaac \
    && which uaac \
    && uaac --version