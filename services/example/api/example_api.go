package api

import (
	"context"

	pb "github.com/Hugo-Villagrana/svelte-go-grpc-envoy-monorepo/apis/proto_stubs/example_service/example/v1/go"
	"github.com/Hugo-Villagrana/svelte-go-grpc-envoy-monorepo/services/example/internal/util"
)

type server struct {
	pb.UnimplementedMyServiceServer
}

func NewServer() *server {
	return &server{}
}

func (s *server) GetMessage(ctx context.Context, in *pb.MyMessageRequest) (*pb.MyMessageResponse, error) {
	return &pb.MyMessageResponse{Id: in.Id, Content: "Hello " + util.Name()}, nil
}
