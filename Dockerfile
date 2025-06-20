# Stage 1: Build
FROM node:18-alpine AS builder

RUN npm install -g pnpm

WORKDIR /app

# Only copy manifest files first to leverage caching
COPY pnpm-lock.yaml ./
COPY package.json ./
COPY packages/utils/package.json ./packages/utils/package.json
COPY packages/vue-shortcuts/package.json ./packages/vue-shortcuts/package.json
COPY site/package.json ./site/package.json

# Install dependencies
RUN pnpm install

# Now copy the rest of the source code
COPY . .

# Build packages in order
RUN pnpm --filter './packages/**' build && pnpm --filter site build

# Stage 2: Serve with Nginx
FROM nginx:alpine

COPY --from=builder /app/site/.output/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

