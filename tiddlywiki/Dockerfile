# Use Home Assistant base image for better integration
ARG BUILD_FROM
ARG BUILD_ARCH="amd64"
ARG BUILD_VERSION="dev"
FROM $BUILD_FROM

# Install Node.js and TiddlyWiki
RUN apk add --no-cache \
    nodejs \
    npm \
    curl \
    bash \
    && npm install -g tiddlywiki@latest \
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

# Health check - using curl instead of wget
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Expose port
EXPOSE 8080

# Start the service
CMD ["/run.sh"]
