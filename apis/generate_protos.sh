#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the root directory for Protobuf files
PROTO_ROOT_DIR="protobufs"

# Function to clear existing generated directories
clear_gen_dirs() {
  find ${PROTO_ROOT_DIR} -type d -name "gen" | while read -r gen_dir; do
    echo -e "${YELLOW}Removing existing directory ${gen_dir}${NC}"
    rm -rf "$gen_dir"
  done
}

# Clear existing generated directories once at the beginning
clear_gen_dirs

# Recursively find all .proto files and generate code
find ${PROTO_ROOT_DIR} -name "*.proto" | while read -r proto_file; do
  # Print the proto file being processed
  echo -e "${GREEN}Processing $proto_file...${NC}"

  # Get the directory of the proto file
  proto_dir=$(dirname "$proto_file")

  # Define the output directories for Go and TypeScript code
  GO_OUT_DIR="${proto_dir}/gen/go"
  TS_OUT_DIR="${proto_dir}/gen/typescript"

  # Create output directories if they do not exist
  mkdir -p ${GO_OUT_DIR}
  mkdir -p ${TS_OUT_DIR}

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
