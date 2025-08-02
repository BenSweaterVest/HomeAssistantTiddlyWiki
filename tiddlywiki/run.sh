#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

# Get configuration
PORT=$(bashio::config 'port')
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')
LOG_LEVEL=$(bashio::config 'log_level')

# Set log level
bashio::log.level "${LOG_LEVEL}"

bashio::log.info "Starting TiddlyWiki..."

# Ensure data directory exists
mkdir -p /data/wiki

# Initialize wiki if it doesn't exist
if [ ! -f "/data/wiki/tiddlywiki.info" ]; then
    bashio::log.info "Initializing new TiddlyWiki..."
    tiddlywiki /data/wiki --init server
    
    # Configure wiki for server-side saving
    bashio::log.info "Configuring wiki for server-side saving..."
    cat > /data/wiki/tiddlywiki.info << 'EOF'
{
	"description": "TiddlyWiki for Home Assistant",
	"plugins": [
		"tiddlywiki/tiddlyweb",
		"tiddlywiki/filesystem",
		"tiddlywiki/highlight"
	],
	"themes": [
		"tiddlywiki/vanilla",
		"tiddlywiki/snowwhite"
	],
	"build": {
		"index": [
			"--rendertiddler",
			"$:/plugins/tiddlywiki/tiddlyweb/save/offline",
			"index.html",
			"text/plain"
		]
	}
}
EOF
    bashio::log.info "Wiki initialized successfully"
fi

# Build TiddlyWiki command
TIDDLYWIKI_CMD="tiddlywiki /data/wiki --listen port=${PORT} host=0.0.0.0"

# Add authentication if configured
if bashio::config.has_value 'username' && bashio::config.has_value 'password'; then
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} username=${USERNAME} password=${PASSWORD}"
    bashio::log.info "Authentication enabled for user: ${USERNAME}"
else
    bashio::log.info "Running without authentication - open access"
fi

# Add verbose logging if debug/trace level
if bashio::config.equals 'log_level' 'debug' || bashio::config.equals 'log_level' 'trace'; then
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} debug-level=verbose"
fi

bashio::log.info "Starting TiddlyWiki on port ${PORT}"
bashio::log.info "Wiki data stored in: /data/wiki/"
bashio::log.info "Access your wiki at: http://homeassistant.local:${PORT}"

# Start TiddlyWiki
exec ${TIDDLYWIKI_CMD}
