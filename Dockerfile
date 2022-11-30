FROM golang:1.19.3-bullseye

RUN dpkg --add-architecture armhf
RUN apt-get update
RUN apt-get install -y gcc-arm-linux-gnueabihf libusb-1.0-0-dev libusb-1.0-0-dev:armhf

ENV GOOS linux
ENV GOARCH arm
ENV GOARM 7
ENV CGO_ENABLED 1
ENV CC arm-linux-gnueabihf-gcc

ARG REPO_DIR=/app
WORKDIR $REPO_DIR

ADD go.mod go.sum main.go $REPO_DIR
RUN go mod download
RUN go build -o lsusb
