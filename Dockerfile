# Use an official Alpine Linux runtime as a parent image
FROM alpine:latest

# Set the working directory in the container
WORKDIR /app

# Define the command to run when the container starts
CMD ["echo", "Hello all"]
