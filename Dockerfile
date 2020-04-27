FROM golang:1.14-alpine3.11 AS build

RUN apk add -X http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/main/ -X http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/community/ --no-cache gcc g++ musl-dev git

WORKDIR /hugo

RUN git clone --branch v0.69.2 https://github.com/gohugoio/hugo.git .
RUN go build -v --tags extended

FROM alpine:3.11

COPY --from=build /hugo/hugo /usr/bin/hugo

RUN apk add -X http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/main/ -X http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/community/ --no-cache ca-certificates libc6-compat libstdc++ git go

VOLUME /site
WORKDIR /site
