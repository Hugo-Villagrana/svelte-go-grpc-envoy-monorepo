#! /bin/bash

# Build Envoy Proxy
docker build -t envoy-proxy -f ./envoy/Dockerfile ./envoy

# Build WealthSnap App
docker build -t example_service -f ./services/example_service/Dockerfile --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" .
