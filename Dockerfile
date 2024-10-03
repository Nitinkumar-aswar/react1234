# Step 1: Build the React app
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project directory to the container
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the React app using nginx
FROM nginx:alpine

# Copy the build output to the Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that nginx will run on
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
