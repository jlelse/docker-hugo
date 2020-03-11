FROM golang:1.14-alpine AS build

RUN echo "" > /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/main/" >> /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/community/" >> /etc/apk/repositories && \
  apk update && \
  apk --no-cache add --no-cache gcc g++ musl-dev git

WORKDIR /hugo

RUN git clone --branch v0.67.0 https://github.com/gohugoio/hugo.git .
RUN go build -v --tags extended

FROM golang:1.14-alpine

COPY --from=build /hugo/hugo /usr/bin/hugo

RUN echo "" > /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/main/" >> /etc/apk/repositories && \
  echo "http://ftp.halifax.rwth-aachen.de/alpine/latest-stable/community/" >> /etc/apk/repositories && \
  apk update && \
  apk --no-cache add --no-cache ca-certificates libc6-compat libstdc++ git

VOLUME /site
WORKDIR /site
