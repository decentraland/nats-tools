FROM golang:1.18-alpine AS builder

WORKDIR $GOPATH/src/github.com/nats-io/

RUN apk add -U --no-cache git binutils

RUN go install github.com/nats-io/nats-top@main
RUN go install github.com/nats-io/natscli/nats@latest

FROM alpine:3.14.6

RUN apk add -U --no-cache ca-certificates figlet vim curl

COPY --from=builder /go/bin/* /usr/local/bin/

WORKDIR /root

USER root

ENTRYPOINT ["/bin/sh", "-l"]
