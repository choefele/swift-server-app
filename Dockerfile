FROM choefele/swift-ubuntu-docker:latest
MAINTAINER Claus

WORKDIR /app

COPY Package.swift /app/
RUN swift package fetch; exit 0

EXPOSE 8090

COPY Sources /app/Sources
RUN swift build -Xcc -fblocks
CMD ./.build/debug/SwiftServer