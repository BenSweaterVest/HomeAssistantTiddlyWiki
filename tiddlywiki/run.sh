#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

# Get configuration with defaults
PORT=$(bashio::config 'port')
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')
LOG_LEVEL=$(bashio::config 'log_level')

# Set log level
bashio::log.level "${LOG_LEVEL}"

bashio::log.info "Starting TiddlyWiki addon..."
bashio::log.info "Configuration - Port: ${PORT}, Log Level: ${LOG_LEVEL}"

# Ensure data directory exists with proper permissions
mkdir -p /data/wiki
chown -R root:root /data/wiki
chmod 755 /data/wiki

# Initialize wiki if it doesn't exist
if [ ! -f "/data/wiki/tiddlywiki.info" ]; then
    bashio::log.info "No existing wiki found. Initializing new TiddlyWiki..."
    
    # Initialize with server edition
    if ! tiddlywiki /data/wiki --init server; then
        bashio::log.error "Failed to initialize TiddlyWiki"
        exit 1
    fi
    
    # Create enhanced tiddlywiki.info with useful plugins
    bashio::log.info "Configuring wiki with recommended plugins..."
    cat > /data/wiki/tiddlywiki.info << 'EOF'
{
	"description": "TiddlyWiki for Home Assistant",
	"plugins": [
		"tiddlywiki/tiddlyweb",
		"tiddlywiki/filesystem",
		"tiddlywiki/highlight",
		"tiddlywiki/markdown",
		"tiddlywiki/codemirror"
	],
	"themes": [
		"tiddlywiki/vanilla",
		"tiddlywiki/snowwhite"
	],
	"languages": [
		"en-US"
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

    # Create a welcome tiddler
    mkdir -p "/data/wiki/tiddlers"
    cat > "/data/wiki/tiddlers/Welcome.tid" << 'EOF'
created: 20240101120000000
modified: 20240101120000000
tags: 
title: Welcome
type: text/vnd.tiddlywiki

! Welcome to your TiddlyWiki!

This TiddlyWiki is running as a Home Assistant addon with server-side saving enabled.

!! Features available:
* Automatic saving of all changes
* Multiple users can edit simultaneously  
* Full TiddlyWiki functionality
* Persistent storage across restarts

!! Getting Started:
# Click the {{$:/core/ui/Buttons/new-tiddler}} button to create your first tiddler
# Use the search box to find existing content
# Tag your tiddlers for better organization
# All changes are automatically saved!

//Happy tiddling!//
EOF

    bashio::log.info "Wiki initialized successfully with welcome content"
else
    bashio::log.info "Existing wiki found, using current configuration"
fi

# Verify TiddlyWiki installation
if ! command -v tiddlywiki >/dev/null 2>&1; then
    bashio::log.error "TiddlyWiki is not installed or not in PATH"
    exit 1
fi

# Build TiddlyWiki command
TIDDLYWIKI_CMD="tiddlywiki /data/wiki --listen"
TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} port=${PORT}"
TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} host=0.0.0.0"
TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} readers=(anon)"
TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} writers=(anon)"

# Add authentication if both username and password are configured
if bashio::config.has_value 'username' && bashio::config.has_value 'password' && [ -n "${USERNAME}" ] && [ -n "${PASSWORD}" ]; then
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} username=${USERNAME} password=${PASSWORD}"
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} readers=(authenticated)"
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} writers=(authenticated)"
    bashio::log.info "Authentication enabled for user: ${USERNAME}"
else
    bashio::log.warning "Running without authentication - anyone on your network can access and edit"
fi

# Add verbose logging for debug levels
if bashio::config.equals 'log_level' 'debug' || bashio::config.equals 'log_level' 'trace'; then
    TIDDLYWIKI_CMD="${TIDDLYWIKI_CMD} debug-level=verbose"
    bashio::log.debug "Verbose logging enabled"
fi

# Log startup information
bashio::log.info "Starting TiddlyWiki server..."
bashio::log.info "Listening on: 0.0.0.0:${PORT}"
bashio::log.info "Data directory: /data/wiki/"
bashio::log.info "Access URL: http://homeassistant.local:${PORT}"

# Add a small delay to ensure logging is visible
sleep 1

# Start TiddlyWiki with error handling
bashio::log.info "Executing: ${TIDDLYWIKI_CMD}"
if ! exec ${TIDDLYWIKI_CMD}; then
    bashio::log.error "TiddlyWiki failed to start"
    exit 1
fi
