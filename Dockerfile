FROM ibmcom/swift-ubuntu:latest
MAINTAINER Claus

WORKDIR /app

COPY Package.swift /app/
RUN swift package fetch

EXPOSE 8090

COPY Sources /app/Sources
RUN swift build -Xcc -fblocks
CMD ./.build/debug/SlackApp