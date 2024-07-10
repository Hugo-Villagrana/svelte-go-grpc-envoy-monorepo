#!/bin/bash

# Function to show usage
usage() {
  echo "Usage: $0 [-b|--build] [--force-recreate]"
  exit 1
}

# Parse command-line arguments
BUILD=false
FORCE_RECREATE=false

while [[ "$1" != "" ]]; do
  case $1 in
  -b | --build)
    BUILD=true
    ;;
  --force-recreate)
    FORCE_RECREATE=true
    ;;
  -h | --help)
    usage
    ;;
  *)
    usage
    ;;
  esac
  shift
done

# If build flag is set, run build-all.sh
if [ "$BUILD" = true ]; then
  echo "Running build-all.sh..."
  ./build-all.sh
fi

# Start Services
echo "Starting services..."
if [ "$FORCE_RECREATE" = true ]; then
  docker-compose up --force-recreate
else
  docker-compose up
fi
