# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.17

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json /app/

## Install dependencies specified in package.json
RUN npm install

# Copy the application code
COPY . .

# Expose the app's port
EXPOSE 8080

# Start the application
CMD ["node", "app.js"]
