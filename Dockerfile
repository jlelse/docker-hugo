FROM golang:1.14-alpine3.11 AS build

RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/v3.11/main/ -X http://dl-cdn.alpinelinux.org/alpine/v3.11/community/ --no-cache gcc g++ musl-dev git

WORKDIR /hugo

RUN git clone --branch v0.72.0 https://github.com/gohugoio/hugo.git .
RUN go build -v --tags extended

FROM alpine:3.11

COPY --from=build /hugo/hugo /usr/bin/hugo

RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/v3.11/main/ -X http://dl-cdn.alpinelinux.org/alpine/v3.11/community/ --no-cache ca-certificates libc6-compat libstdc++ git go

VOLUME /site
WORKDIR /site
