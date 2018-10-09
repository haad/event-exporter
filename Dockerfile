FROM golang:1.10.4-stretch as builder

COPY . /go/src/github.com/haad/event-exporter
WORKDIR /go/src/github.com/haad/event-exporter

RUN make build

FROM alpine:3.7
COPY --from=builder /go/src/github.com/haad/event-exporter/bin/event-exporter /usr/bin/event-exporter

ENTRYPOINT ["/usr/bin/event-exporter"]

CMD ["-v", "4"]
