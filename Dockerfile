FROM golang:1.22.0 AS builder

WORKDIR /app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main

FROM alpine AS app

WORKDIR /app

COPY --from=builder /app/main /app/tracker.db ./

CMD ["./main"]