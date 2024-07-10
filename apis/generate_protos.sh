#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the root directory for Protobuf files
PROTO_ROOT_DIR="protos"
PROTO_STUBS_DIR="proto_stubs"

# Clear existing generated directories once at the beginning
rm -rf PROTO_STUBS_DIR

# Recursively find all .proto files and generate code
find ${PROTO_ROOT_DIR} -name "*.proto" | while read -r proto_file; do
  # Print the proto file being processed
  echo -e "${GREEN}Processing $proto_file...${NC}"

  # Get the directory and file name of the proto file
  proto_dir=$(dirname "$proto_file")
  proto_out="${proto_dir#protos/}"

  # Define the output directories for Go and TypeScript code
  GO_OUT_DIR="proto_stubs/${proto_out}/go"
  TS_OUT_DIR="proto_stubs/${proto_out}/typescript"

  # Create the output directories
  mkdir -p "${GO_OUT_DIR}"
  mkdir -p "${TS_OUT_DIR}"

  # Generate Go code
  protoc --proto_path=${proto_dir} --go_out=${GO_OUT_DIR} --go_opt=paths=source_relative \
    --go-grpc_out=${GO_OUT_DIR} --go-grpc_opt=paths=source_relative \
    ${proto_dir}/*.proto

  # Generate TS code
  npx protoc \
    --ts_out ${TS_OUT_DIR} \
    --ts_opt long_type_string \
    --ts_opt generate_dependencies \
    --ts_opt use_proto_field_name \
    --ts_opt add_pb_suffix \
    --proto_path ${proto_dir} \
    ${proto_dir}/*.proto

done

echo -e "${GREEN}Protobuf generation completed.${NC}"
