#! /bin/bash

# Build Envoy Proxy
docker build -t envoy-proxy -f ./envoy/Dockerfile ./envoy

# Build Example Monorepo App
docker build -t example_monorepo -f ./services/example_monorepo/Dockerfile --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" .
