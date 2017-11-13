FROM swift:4 

RUN apt-get update && apt-get install -y openssl libssl-dev
COPY Package.swift Package.resolved /code/ 
WORKDIR /code
RUN swift build || true
COPY ./Sources /code/Sources
RUN swift build
EXPOSE 8000
CMD .build/debug/kitura-threading
