FROM golang:1.10.4-alpine3.7 as builder

COPY . /go/src/github.com/haad/event-exporter
WORKDIR /go/src/github.com/haad/event-exporter

RUN apk add --update git make

RUN go get -u github.com/golang/dep/cmd/dep && \
    dep ensure && \
    make build

FROM alpine:3.7
COPY --from=builder /go/src/github.com/haad/event-exporter/bin/event-exporter /usr/bin/event-exporter

ENTRYPOINT ["/usr/bin/event-exporter"]

CMD ["-v", "4"]
