FROM golang:1.13-alpine AS build

RUN apk update && apk add --no-cache gcc g++ musl-dev git

WORKDIR /hugo

RUN git clone --branch v0.63.2 https://github.com/gohugoio/hugo.git .
RUN go build -v --tags extended

FROM golang:1.13-alpine

COPY --from=build /hugo/hugo /usr/bin/hugo

RUN apk update && apk add --no-cache ca-certificates libc6-compat libstdc++ git

VOLUME /site
WORKDIR /site