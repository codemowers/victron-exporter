FROM golang:1.23 AS build
WORKDIR /go/src/github.com/codemowers/victron-exporter/
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -ldflags "-linkmode 'external' -extldflags '-static'" -o /victron-exporter .

FROM scratch
WORKDIR /
COPY --from=build /victron-exporter /victron-exporter
ENTRYPOINT ["/victron-exporter"]
