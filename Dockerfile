# Stage 1: Build
FROM node:18-alpine AS builder

RUN npm install -g pnpm

WORKDIR /app
COPY . .

# Install dependencies
RUN pnpm install

# 🛠 Explicitly build dependencies in order
#RUN pnpm --filter=utils build && pnpm --filter=site build
#RUN pnpm --filter=utils build && pnpm --filter=vue-shortcuts build && pnpm --filter=site build
RUN pnpm --filter './packages/**' build && pnpm --filter site build



# Stage 2: Serve with Nginx
FROM nginx:alpine

COPY --from=builder /app/site/.output/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

