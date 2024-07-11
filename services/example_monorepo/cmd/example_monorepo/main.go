package main

import (
	"fmt"
	pb "github.com/Hugo-Villagrana/svelte-go-grpc-envoy-monorepo/apis/proto_stubs/example_service/example/v1/go"
	"log"
	"net"

	example "github.com/Hugo-Villagrana/svelte-go-grpc-envoy-monorepo/services/example/api"
	"google.golang.org/grpc"
)

const (
	SERVICE_PORT = 50051
	SERVICE_HOST = "localhost"
)

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", SERVICE_PORT))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()

	// Register Example Service
	exampleServer := example.NewServer()
	pb.RegisterMyServiceServer(s, exampleServer)

	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
