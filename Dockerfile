FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main

FROM alpine AS app

WORKDIR /app

COPY --from=builder /main /main

CMD ["/main"]