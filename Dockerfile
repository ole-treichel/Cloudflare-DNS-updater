FROM rust:1.60 as builder
WORKDIR /usr/src/cloudflare_dns_updater
COPY . .
RUN cargo install --path .

FROM debian:buster-slim
COPY --from=builder /usr/local/cargo/bin/cloudflare_dns_updater /usr/local/bin/cloudflare_dns_updater
CMD ["cloudflare_dns_updater"]
