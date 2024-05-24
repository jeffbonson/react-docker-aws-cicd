# Use a specific version of Node.js
FROM node:16.13.1-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

FROM nginx

# Expose port 80 to the outside world
EXPOSE 80

# Copy the built React app to the Nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html

# Start Nginx in the foreground
# CMD ["nginx", "start"] This command is typically used to start a development server using npm start. However, since you're using Nginx to serve the built React app, you don't need to run npm start

CMD ["nginx", "-g", "daemon off;"]
