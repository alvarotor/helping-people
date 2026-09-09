FROM python:3.12-slim
WORKDIR /app
COPY apps/ai/requirements.txt ./apps/ai/requirements.txt
RUN pip install --no-cache-dir -r apps/ai/requirements.txt
COPY apps/ai ./apps/ai
COPY packages/contracts/generated/python ./packages/contracts/generated/python
RUN useradd --create-home --uid 10001 app
USER app
EXPOSE 50051 8084
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8084/health', timeout=2)"
CMD ["python", "apps/ai/main.py"]
