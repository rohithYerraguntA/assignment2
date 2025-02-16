# Use an official lightweight Node.js image as a base
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install --production

# Copy the application source code
COPY . .

# Expose the port that the app runs on
EXPOSE 8080

# Command to start the application
CMD ["node", "src/index.js"]
