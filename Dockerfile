FROM golang:1.13-alpine AS build

RUN echo "" > /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.11/main/" >> /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.11/community/" >> /etc/apk/repositories && \
  apk update && \
  apk --no-cache add --no-cache gcc g++ musl-dev git

WORKDIR /hugo

RUN git clone --branch v0.65.1 https://github.com/gohugoio/hugo.git .
RUN go build -v --tags extended

FROM golang:1.13-alpine

COPY --from=build /hugo/hugo /usr/bin/hugo

RUN echo "" > /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.11/main/" >> /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.11/community/" >> /etc/apk/repositories && \
  apk update && \
  apk --no-cache add --no-cache ca-certificates libc6-compat libstdc++ git

VOLUME /site
WORKDIR /site
