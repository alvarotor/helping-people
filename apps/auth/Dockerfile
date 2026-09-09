FROM node:24-alpine AS build
WORKDIR /app
COPY apps/auth/package.json apps/auth/tsconfig.json ./
RUN npm install
COPY apps/auth/src ./src
RUN npm run build

FROM node:24-alpine
WORKDIR /app
RUN addgroup -S app && adduser -S -G app app
COPY --from=build /app/package.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
USER app
EXPOSE 8083
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:8083/livez || exit 1
CMD ["node", "dist/index.js"]
