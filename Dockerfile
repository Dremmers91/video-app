# Use a node base image
FROM node:latest as builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy prisma schema and generate prisma client
COPY prisma ./prisma
RUN npx prisma generate

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Start a new, final image to reduce size
FROM node:latest

WORKDIR /app

# Copy the built app and the .next folder from the builder image
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./

# Copy other necessary files such as env files and next config
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/.env* ./

# The port your app will run on
EXPOSE 3000

# The command to start your app
CMD ["npm", "start"]
