FROM node:24-alpine AS build
WORKDIR /app
COPY apps/admin/package.json apps/admin/tsconfig.json apps/admin/vite.config.ts apps/admin/index.html ./
RUN npm install
COPY apps/admin/src ./src
RUN npm run build

FROM nginx:1.29-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:80/ || exit 1
