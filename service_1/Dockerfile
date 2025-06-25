FROM golang:1.20-alpine

# Install curl for healthcheck
RUN apk add --no-cache curl

WORKDIR /app
COPY . .
CMD ["go", "run", "main.go"]

