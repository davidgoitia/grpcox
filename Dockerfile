FROM golang:1.13-alpine AS builder

ENV GO111MODULE=on

#WORKDIR /go/src/github.com/davidgoitia/grpcox
WORKDIR /src

COPY . ./
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o grpcox grpcox.go


FROM alpine

COPY ./index /index
COPY --from=builder /src/grpcox ./
RUN mkdir /log
EXPOSE 8777
ENTRYPOINT ["./grpcox"]
