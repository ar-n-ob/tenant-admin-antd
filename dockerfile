# Use an official Node runtime as the base image
FROM node:18-alpine as builder

# Set the working directory in the container
WORKDIR /app

COPY . .

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the remaining application code to the working directory
COPY . .

# Build the application
RUN yarn build

# Use Nginx as the web server to serve the application
FROM nginx:alpine

# Copy the built application from the builder stage to the Nginx web server directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
