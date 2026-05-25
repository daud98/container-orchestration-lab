# Stage 1: Build environment
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Stage 2: Production environment
FROM node:20-alpine AS production
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/package*.json ./
RUN npm ci --only=production
COPY --from=build /app/server.js ./ 

# Run as non-root user for security hardening
USER node
EXPOSE 3000
CMD ["node", "server.js"]