FROM swift:4 

RUN apt-get update && apt-get install -y openssl libssl-dev
COPY Package.swift /code/Package.swift
WORKDIR /code
RUN swift build
COPY ./Sources /code/Sources
RUN swift build
EXPOSE 8000
CMD .build/debug/kitura-threading
