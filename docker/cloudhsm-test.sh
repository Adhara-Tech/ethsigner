#!/bin/bash
set -eo pipefail


docker run --rm --name ethsigner \
  -e HSM_IP="10.1.0.171" \
  -v $PWD/ecd7b37cb0d7220eee1c970669b16b635de60196.toml:/etc/ethsigner/keyfiles/ecd7b37cb0d7220eee1c970669b16b635de60196.toml \
  -v $PWD/customerCA.crt:/opt/cloudhsm/etc/customerCA.crt \
  -p 6545:6545 \
  adharaprojects/ethsigner:0.7.0-ADHARA-SNAPSHOT-cloudhsm \
  --chain-id=44844  \
  --downstream-http-host=host.docker.internal  \
  --downstream-http-port=8545 \
  --http-listen-port=6545 \
  --http-listen-host="0.0.0.0" \
  --downstream-http-request-timeout=30000 \
  multikey-signer \
  --directory="/etc/ethsigner/keyfiles/" \
  --library="/opt/cloudhsm/lib/libcloudhsm_pkcs11.so" \
  --slot-label="cavium" \
  --slot-pin="alice:*******"