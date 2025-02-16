# Use Node.js 18 Alpine (lightweight version)
FROM node:18-alpine

# Set environment variable (modify as needed)
ENV NODE_ENV=production

# Create and set the working directory
WORKDIR /app

# Copy package files first (to leverage Docker layer caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --only=production

# Copy the entire project directory
COPY . .

# Change ownership permissions to "node" recursively
RUN chown -R node:node /app

# Switch to the "node" user for better security
USER node

# Expose application port (Cloud Run defaults to 8080, update if needed)
EXPOSE 8080

# Start the application (modify if your entry point is different)
CMD ["node", "server.js"]
