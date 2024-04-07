# Use an official Node runtime as the base image
FROM node:14-alpine as builder

# Set the working directory in the container
WORKDIR /app

COPY . .

# Install dependencies
RUN npm install --production

# Build the application
RUN npm run deploy

# Use Nginx as the web server to serve the application
FROM nginx:alpine

# Copy the built application from the builder stage to the Nginx web server directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
