#!/bin/bash

# Hugo version required by hugo-theme-reimu
HUGO_VERSION="0.131.0"

echo "Installing Hugo ${HUGO_VERSION}..."

# Detect OS and architecture
if [ "$(uname)" = "Linux" ]; then
    if [ "$(uname -m)" = "aarch64" ]; then
        HUGO_ARCH="Linux-ARM64"
    else
        HUGO_ARCH="Linux-64bit"
    fi
elif [ "$(uname)" = "Darwin" ]; then
    if [ "$(uname -m)" = "arm64" ]; then
        HUGO_ARCH="macOS-ARM64"
    else
        HUGO_ARCH="macOS-64bit"
    fi
else
    echo "Unsupported OS: $(uname)"
    exit 1
fi

HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_${HUGO_ARCH}.tar.gz"

# Download Hugo
echo "Downloading Hugo from: $HUGO_URL"
curl -L -o hugo.tar.gz "$HUGO_URL"

# Extract Hugo
tar -xzf hugo.tar.gz

# Make Hugo executable
chmod +x hugo

# Verify Hugo version
echo "Hugo version:"
./hugo version

# Build the site
echo "Building site..."
./hugo --gc --minify

echo "Build completed!"
