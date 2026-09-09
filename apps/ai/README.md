# AI Adapter Service

Minimal gRPC AI adapter scaffold. It exposes the approved protobuf service and standard health status, but business methods intentionally return `UNIMPLEMENTED` until an AI implementation proposal is approved.

The adapter is stateless. The backend owns authorization, persistence, profile merging, request lifecycle, and publication.

## Local

```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
PYTHONPATH=../../packages/contracts/generated/python python3 main.py
```

gRPC default port: `50051`. HTTP health default port: `8084`.
