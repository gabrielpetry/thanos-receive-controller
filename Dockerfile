FROM golang:1.21-alpine as builder

WORKDIR /workspace

COPY go.mod go.sum ./

RUN go mod download

COPY main.go .

RUN go build -o thanos-receive-controller main.go

FROM alpine

COPY --from=builder /workspace/thanos-receive-controller /usr/bin/thanos-receive-controller

ENTRYPOINT ["/usr/bin/thanos-receive-controller"]
