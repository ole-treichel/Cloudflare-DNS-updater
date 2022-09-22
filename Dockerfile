FROM rust:1.60 as builder
WORKDIR /usr/src/cloudflare_dns_updater
COPY . .
RUN cargo install --path .

FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/cloudflare_dns_updater /usr/local/bin/cloudflare_dns_updater
CMD ["cloudflare_dns_updater"]
