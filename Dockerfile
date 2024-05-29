# Use the official Maven image as the base
FROM maven:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the source files into the container
COPY src/ .

# Command to run your application
CMD ["java", "App"]
