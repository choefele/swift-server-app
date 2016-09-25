FROM ibmcom/swift-ubuntu:latest
MAINTAINER Claus

WORKDIR /app

COPY Package.swift ./
RUN swift package fetch; exit 0

EXPOSE 8090

COPY Sources ./Sources
COPY Tests ./Tests
RUN swift test
CMD ./.build/debug/SwiftServer