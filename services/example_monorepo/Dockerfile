# Stage 1: Build Stage
FROM golang:1.21-alpine AS builder

# Install git and openssh
RUN apk add --no-cache git openssh
RUN git config --global url.ssh://git@github.com/.insteadOf https://github.com/

# Set the working directory inside the container
WORKDIR /app

# Use build arguments for SSH private key
ARG SSH_PRIVATE_KEY

# Create the .ssh directory and set permissions
RUN mkdir -p /root/.ssh && \
    echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_ed25519 && \
    chmod 600 /root/.ssh/id_ed25519 && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts
# Copy go.mod and go.sum files from the context to the working directory
COPY go.mod go.sum ./

# Download Go modules
RUN GIT_SSH_COMMAND="ssh -i /root/.ssh/id_ed25519" go mod download

# Clean up SSH keys
RUN rm -rf /root/.ssh

# Copy the rest of the application code to the working directory
COPY . .

# Build the Go application
RUN go build -o example_monorepo ./services/example_monorepo/cmd/example_monorepo

# Stage 2: Final Stage
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built Go application from the builder stage
COPY --from=builder /app/example_monorepo /app/example_monorepo

# Expose the port that the service will run on
EXPOSE 50051

# Command to run the executable
CMD ["./example_monorepo"]

