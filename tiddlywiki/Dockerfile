# Use Home Assistant base image for better integration
ARG BUILD_FROM
ARG BUILD_ARCH="amd64"
ARG BUILD_VERSION="dev"
ARG TIDDLYWIKI_VERSION="5.3.6"
FROM $BUILD_FROM

# Install Node.js and TiddlyWiki
RUN apk add --no-cache \
    nodejs \
    npm \
    curl \
    bash \
    && npm install -g "tiddlywiki@${TIDDLYWIKI_VERSION}" \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf ~/.npm

# Copy run script and make executable
COPY run.sh /
RUN chmod a+x /run.sh

# Create data directory
RUN mkdir -p /data/wiki

# Labels for Home Assistant
LABEL \
    io.hass.name="TiddlyWiki" \
    io.hass.description="TiddlyWiki personal wiki system" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="BenSweatervest <benjiman.blanchard@gmail.com>" \
    io.hass.base.version="${BUILD_VERSION}" \
    io.hass.base.name="${BUILD_FROM}"

# We rely on Home Assistant's watchdog (configured in config.yaml) instead of
# Docker HEALTHCHECK. The add-on service listens on container port 8080.

# Expose service port (host-side mapping is configured in Home Assistant).
EXPOSE 8080

# Start the service
CMD ["/run.sh"]
