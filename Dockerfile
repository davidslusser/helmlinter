FROM alpine:latest

RUN apk add --no-cache wget

# Set the version and URL of Helm
ENV HELM_VERSION="v3.14.0"
ENV HELM_URL="https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz"

# Download and extract Helm
RUN wget -O helm.tar.gz "$HELM_URL" && \
    tar -zxvf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 helm.tar.gz

COPY helmlinter.sh /app/helmlinter.sh

WORKDIR /app

ENTRYPOINT ["./helmlinter.sh"]
