# Build Stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Secure Runtime Stage
FROM gcr.io/distroless/nodejs20-debian12
USER 10001:10001            # non-root user
WORKDIR /app
COPY --from=build /app /app
CMD ["/app/server.js"]