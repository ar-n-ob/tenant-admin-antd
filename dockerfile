# Use a Node.js base image
FROM node:16-alpine as builder

# Set the working directory in the container
WORKDIR /app

COPY . .

RUN npm install -g pnpm

# Copy package.json and package-lock.json to the container
COPY package*.json ./


# Install project dependencies
RUN pnpm install

# Build the production version of the project
RUN pnpm build

# Stage 2: Serve the built application using Nginx
FROM nginx:alpine

# Copy the built application from the builder stage to the nginx directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]