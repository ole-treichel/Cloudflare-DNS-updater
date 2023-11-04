FROM rust:1.63 as builder
WORKDIR /usr/src/cloudflare_dns_updater
COPY . .
RUN cargo install --path .

FROM debian:bullseye-slim
RUN apt-get install -y extra-runtime-dependencies openssl & rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/cloudflare_dns_updater /usr/local/bin/cloudflare_dns_updater

CMD ["cloudflare_dns_updater"]
