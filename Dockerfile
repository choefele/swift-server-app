FROM swift:3.1
MAINTAINER Claus

WORKDIR /app

RUN apt-get update && apt-get install -y \
  libssl-dev \
  && rm -rf /var/lib/apt/lists/*

COPY Package.swift ./
RUN swift package fetch; exit 0

EXPOSE 8090

COPY Sources ./Sources
COPY Tests ./Tests
RUN swift test
CMD ./.build/debug/SwiftServer