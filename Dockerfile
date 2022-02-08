FROM ubuntu:focal AS builder

RUN apt update -y && apt install -y wget \
  && export DATE_VERSION=$(date +%Y-%m) \
  && mkdir -p /tmp/geo \
  && cd /tmp/geo \
  && wget "https://download.db-ip.com/free/dbip-country-lite-${DATE_VERSION}.mmdb.gz" -O dbip-country-lite.gz \
  && gunzip dbip-country-lite.gz \
  && mv dbip-country-lite dbip-country-lite.mmdb \
  && wget "https://download.db-ip.com/free/dbip-city-lite-${DATE_VERSION}.mmdb.gz" -O dbip-city-lite.gz \
  && gunzip dbip-city-lite.gz \
  && mv dbip-city-lite dbip-city-lite.mmdb \
  && wget "https://download.db-ip.com/free/dbip-asn-lite-${DATE_VERSION}.mmdb.gz" -O dbip-asn-lite.gz \
  && gunzip dbip-asn-lite.gz \
  && mv dbip-asn-lite dbip-asn-lite.mmdb

FROM scratch

COPY --from=builder /tmp/geo/*.mmdb /
