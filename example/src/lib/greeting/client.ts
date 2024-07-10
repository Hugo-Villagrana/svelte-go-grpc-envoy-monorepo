import type { FinishedUnaryCall } from '@protobuf-ts/runtime-rpc';
import type {
	MyMessageRequest,
	MyMessageResponse
} from '../../../../apis/proto_stubs/example_service/example/typescript/example_api_pb';
import { MyServiceClient } from '../../../../apis/proto_stubs/example_service/example/typescript/example_api_pb.client';
import { GrpcWebFetchTransport } from '@protobuf-ts/grpcweb-transport';

const hostname = 'http://localhost:8080';
let transport = new GrpcWebFetchTransport({
	baseUrl: hostname,
	format: 'binary'
});
const client: MyServiceClient = new MyServiceClient(transport);
export async function getMessage(id: string): Promise<string> {
	const request: MyMessageRequest = { id };
	try {
		const res: FinishedUnaryCall<MyMessageRequest, MyMessageResponse> =
			await client.getMessage(request);
		return res.response.content;
	} catch (e) {
		let errMessage: string;
		if (e instanceof Error) {
			errMessage = e.message;
		} else {
			errMessage = 'unknown err message';
		}
		console.error(`Failed to get message: ${errMessage}`);
		return Promise.reject(errMessage);
	}
}
