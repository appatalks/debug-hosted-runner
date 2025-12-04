#!/usr/bin/env bash
set -euo pipefail

ASSET_DIR="$(dirname "$0")"
PRIVATE_KEY="$ASSET_DIR/id_rsa_test"
PUBLIC_KEY="$ASSET_DIR/id_rsa_test.pub"

if [ -f "$PRIVATE_KEY" ] && [ -f "$PUBLIC_KEY" ]; then
  echo "Test keys already exist: $PRIVATE_KEY"
  exit 0
fi

echo "Generating SSH test key pair in $ASSET_DIR"
ssh-keygen -t rsa -b 4096 -f "$PRIVATE_KEY" -N "" -C "debug-runner-test-key"

echo "Copying public key to ssh-server/authorized_keys (for image build)"
mkdir -p "$ASSET_DIR/../ssh-server"
cp -f "$PUBLIC_KEY" "$ASSET_DIR/../ssh-server/authorized_keys"

echo "Generated:
  private: $PRIVATE_KEY
  public:  $PUBLIC_KEY
  Also copied public key to ssh-server/authorized_keys"
