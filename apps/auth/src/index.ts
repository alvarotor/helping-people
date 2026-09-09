import { createServer } from 'node:http';

const port = Number(process.env.PORT || 8083);

const server = createServer((request, response) => {
  if (request.method === 'GET' && request.url === '/livez') {
    return json(response, 200, { status: 'ok' });
  }
  if (request.method === 'GET' && request.url === '/readyz') {
    return json(response, 200, { status: 'ready' });
  }
  if (request.method === 'GET' && request.url === '/health') {
    return json(response, 200, { status: 'ok' });
  }
  return json(response, 404, { code: 'not_found' });
});

server.listen(port, () => {
  console.log(JSON.stringify({ event: 'auth_started', port }));
});

const shutdown = () => server.close(() => process.exit(0));
process.once('SIGINT', shutdown);
process.once('SIGTERM', shutdown);

function json(response: import('node:http').ServerResponse, status: number, body: unknown) {
  response.writeHead(status, { 'content-type': 'application/json' });
  response.end(JSON.stringify(body));
}
