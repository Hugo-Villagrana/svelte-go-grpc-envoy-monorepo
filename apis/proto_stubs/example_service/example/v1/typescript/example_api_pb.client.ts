// @generated by protobuf-ts 2.9.4 with parameter long_type_string,generate_dependencies,use_proto_field_name,add_pb_suffix
// @generated from protobuf file "example_api.proto" (package "example_service.example.v1", syntax proto3)
// tslint:disable
import type { RpcTransport } from "@protobuf-ts/runtime-rpc";
import type { ServiceInfo } from "@protobuf-ts/runtime-rpc";
import { MyService } from "./example_api_pb";
import { stackIntercept } from "@protobuf-ts/runtime-rpc";
import type { MyMessageResponse } from "./example_api_pb";
import type { MyMessageRequest } from "./example_api_pb";
import type { UnaryCall } from "@protobuf-ts/runtime-rpc";
import type { RpcOptions } from "@protobuf-ts/runtime-rpc";
/**
 * The service definition.
 *
 * @generated from protobuf service example_service.example.v1.MyService
 */
export interface IMyServiceClient {
    /**
     * Sends a greeting
     *
     * @generated from protobuf rpc: GetMessage(example_service.example.v1.MyMessageRequest) returns (example_service.example.v1.MyMessageResponse);
     */
    getMessage(input: MyMessageRequest, options?: RpcOptions): UnaryCall<MyMessageRequest, MyMessageResponse>;
}
/**
 * The service definition.
 *
 * @generated from protobuf service example_service.example.v1.MyService
 */
export class MyServiceClient implements IMyServiceClient, ServiceInfo {
    typeName = MyService.typeName;
    methods = MyService.methods;
    options = MyService.options;
    constructor(private readonly _transport: RpcTransport) {
    }
    /**
     * Sends a greeting
     *
     * @generated from protobuf rpc: GetMessage(example_service.example.v1.MyMessageRequest) returns (example_service.example.v1.MyMessageResponse);
     */
    getMessage(input: MyMessageRequest, options?: RpcOptions): UnaryCall<MyMessageRequest, MyMessageResponse> {
        const method = this.methods[0], opt = this._transport.mergeOptions(options);
        return stackIntercept<MyMessageRequest, MyMessageResponse>("unary", this._transport, method, opt, input);
    }
}
