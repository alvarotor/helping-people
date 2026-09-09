from __future__ import annotations

import asyncio
import os
import sys
from pathlib import Path

import grpc
from grpc_health.v1 import health, health_pb2, health_pb2_grpc

generated = Path(__file__).resolve().parents[2] / "packages" / "contracts" / "generated" / "python"
sys.path.insert(0, str(generated))

import ai_pb2  # noqa: E402
import ai_pb2_grpc  # noqa: E402


class ScaffoldAiService(ai_pb2_grpc.AiServiceServicer):
    async def _unimplemented(self, context: grpc.aio.ServicerContext) -> None:
        await context.abort(grpc.StatusCode.UNIMPLEMENTED, "AI behavior is not implemented in the scaffold")

    async def GenerateAssistantReply(self, request, context):
        await self._unimplemented(context)

    async def ExtractServiceRequest(self, request, context):
        await self._unimplemented(context)

    async def ExtractProfessionalProfile(self, request, context):
        await self._unimplemented(context)

    async def Embed(self, request, context):
        await self._unimplemented(context)

    async def EmbedBatch(self, request, context):
        await self._unimplemented(context)


async def health_server(port: int) -> asyncio.AbstractServer:
    async def handle(reader: asyncio.StreamReader, writer: asyncio.StreamWriter) -> None:
        await reader.read(4096)
        body = b'{"status":"ok"}\n'
        writer.write(b"HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: " + str(len(body)).encode() + b"\r\nConnection: close\r\n\r\n" + body)
        await writer.drain()
        writer.close()
        await writer.wait_closed()

    return await asyncio.start_server(handle, "0.0.0.0", port)


async def main() -> None:
    grpc_port = int(os.getenv("GRPC_PORT", "50051"))
    http_port = int(os.getenv("HTTP_PORT", "8084"))
    server = grpc.aio.server()
    ai_pb2_grpc.add_AiServiceServicer_to_server(ScaffoldAiService(), server)
    health_service = health.HealthServicer()
    health_service.set("", health_pb2.HealthCheckResponse.SERVING)
    health_pb2_grpc.add_HealthServicer_to_server(health_service, server)
    server.add_insecure_port(f"[::]:{grpc_port}")
    await server.start()
    http = await health_server(http_port)
    print({"event": "ai_started", "grpc_port": grpc_port, "http_port": http_port}, flush=True)
    try:
        await server.wait_for_termination()
    finally:
        http.close()
        await http.wait_closed()
        await server.stop(5)


if __name__ == "__main__":
    asyncio.run(main())
