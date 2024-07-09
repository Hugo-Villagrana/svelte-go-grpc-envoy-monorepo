# Protobuf Setup and Code Generation

This guide provides instructions on how to set up your environment to work with Protobufs and generate Go code from Protobuf definitions.

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Go](https://golang.org/doc/install)

## Quick Start

Clone this repo and run these commands to generate Protbuf Stubs

```bash
npm install
go mod download
./generate_protos.sh
```

## Installation Steps

### 1. Install `protoc` with Homebrew

Install the Protocol Buffers compiler (`protoc`) using Homebrew:

```bash
brew install protobuf
```

### 2. Install Dependencies

Install the `protoc-gen-go` and `protoc-gen-go-grpc` plugins using Go:

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

Install the `ts-proto` package for TS:

```bash
npm install protoc-gen-grpc-web
npm install ts-proto --save-dev
```

### 3. Add Go Bin Directory to PATH

Make sure that the Go bin directory is included in your PATH. The Go bin directory is typically `$(go env GOPATH)/bin`.

#### For Unix-based Systems

Add the following line to your shell profile file (e.g., `~/.bashrc`, `~/.zshrc`, etc.):

```bash
export PATH="$PATH:$(go env GOPATH)/bin"
```

To apply the changes, run:

```bash
source ~/.bashrc
```

To make this change permanent, add the above line to your shell profile file (e.g., ~/.bashrc, ~/.zshrc, etc.):

```bash
echo 'export PATH="$PATH:$(go env GOPATH)/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 4. Verify Installation

Verify that `protoc`, `protoc-gen-go`, and `protoc-gen-go-grpc` are installed correctly:

```bash
protoc --version
protoc-gen-go --version
protoc-gen-go-grpc --version
```

### 5. Generate Protobuf Stubs

Use the following command as an example to generate Go code from your Protobuf Stubs:

```bash
protoc --go_out=protobufs/example_service/example/v1/gen/go --go_opt=paths=source_relative \
       --go-grpc_out=protobufs/example_service/example/v1/gen/go --go-grpc_opt=paths=source_relative \
       protobufs/example_service/example/v1/example_api.proto
```

Use the following command as an example to generate TS code from your Protobuf Stubs:

```bash
  protoc \
    --proto_path=${proto_dir} \
    --plugin=./node_modules/.bin/protoc-gen-ts_proto \
    --ts_proto_out=${TS_OUT_DIR} \
    --ts_proto_opt=outputClientImpl=grpc-web \
    "$proto_file"
```

## Example Protobuf File

Here is a complete example of a Protobuf file with the `option go_package`:

```proto
syntax = "proto3";

package example_service.example.v1;

// Specify the Go package for the generated code.
option go_package = "github.com/Hugo-Villagrana/example_service-apis/protobufs/example_service/example/v1;example";

// The request message containing the user's ID.
message MyMessage {
  string id = 1;
  string content = 2;
}

// The service definition.
service MyService {
  // Sends a greeting
  rpc GetMessage (MyMessage) returns (MyMessage);
}
```

## Additional Resources

- [Protocol Buffers Language Guide](https://developers.google.com/protocol-buffers/docs/proto3)
- [gRPC Quick Start: Go](https://grpc.io/docs/languages/go/quickstart/)
- [gRPC-Web](https://grpc.io/docs/platforms/web/)
