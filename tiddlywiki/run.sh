#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: TiddlyWiki
# Runs TiddlyWiki server with server-side saving
# ==============================================================================
# shellcheck shell=bash
set -eu

# Enable pipefail when supported by the shell.
if (set -o pipefail 2>/dev/null); then
    set -o pipefail
fi

# ------------------------------------------------------------------------------
# Load Home Assistant-managed options used by this script.
# ------------------------------------------------------------------------------
USERNAME=$(bashio::config 'username')
PASSWORD=$(bashio::config 'password')
LOG_LEVEL=$(bashio::config 'log_level')
AUTH_MODE=$(bashio::config 'auth_mode')

# Set log level
bashio::log.level "${LOG_LEVEL}"

bashio::log.info "Starting TiddlyWiki addon..."
bashio::log.info "Configuration - Port: 8080 (container), Auth Mode: ${AUTH_MODE}, Log Level: ${LOG_LEVEL}"

# ------------------------------------------------------------------------------
# Verify installation
# ------------------------------------------------------------------------------
# Verify TiddlyWiki installation before any initialization path uses it.
if ! command -v tiddlywiki >/dev/null 2>&1; then
    bashio::log.error "TiddlyWiki is not installed or not in PATH"
    exit 1
fi

# ------------------------------------------------------------------------------
# Prepare data directory
# ------------------------------------------------------------------------------
# Ensure data directory exists with expected base permissions.
mkdir -p /data/wiki
# Avoid recursive ownership scans on every boot; only correct when parent owner drifts.
if [ "$(stat -c '%u:%g' /data/wiki)" != "0:0" ]; then
    bashio::log.info "Correcting /data/wiki ownership to root:root"
    chown root:root /data/wiki
fi
chmod 755 /data/wiki

# ------------------------------------------------------------------------------
# Initialize TiddlyWiki if needed
# ------------------------------------------------------------------------------
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
    if ! cat > /data/wiki/tiddlywiki.info << 'EOF'
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
    then
        bashio::log.error "Failed to write /data/wiki/tiddlywiki.info"
        exit 1
    fi

    # Create a welcome tiddler
    mkdir -p "/data/wiki/tiddlers"
    if ! cat > "/data/wiki/tiddlers/Welcome.tid" << 'EOF'
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
    then
        bashio::log.error "Failed to write /data/wiki/tiddlers/Welcome.tid"
        exit 1
    fi

    bashio::log.info "Wiki initialized successfully with welcome content"
else
    bashio::log.info "Existing wiki found, using current configuration"
fi

# ------------------------------------------------------------------------------
# Build TiddlyWiki server command
# ------------------------------------------------------------------------------
# Build `tiddlywiki --listen` as an argument array to preserve credential escaping.
TIDDLYWIKI_CMD=(tiddlywiki /data/wiki --listen)
TIDDLYWIKI_CMD+=(port=8080)
TIDDLYWIKI_CMD+=(host=0.0.0.0)
# Default to anonymous access (will be overridden if auth is enabled)
TIDDLYWIKI_CMD+=("readers=(anon)")
TIDDLYWIKI_CMD+=("writers=(anon)")

# ------------------------------------------------------------------------------
# Configure authentication
# ------------------------------------------------------------------------------
# Authentication modes:
# - none: open read/write access (trusted networks only)
# - edit: open read access, authenticated write access
# - all: authenticated read/write access
case "${AUTH_MODE}" in
    none)
        bashio::log.warning "Auth mode 'none': anyone on your network can access and edit"
        ;;
    edit)
        if [ -z "${USERNAME}" ] || [ -z "${PASSWORD}" ]; then
            bashio::log.error "Auth mode 'edit' requires both username and password"
            exit 1
        fi
        TIDDLYWIKI_CMD+=("username=${USERNAME}")
        TIDDLYWIKI_CMD+=("password=${PASSWORD}")
        TIDDLYWIKI_CMD+=("readers=(anon)")
        TIDDLYWIKI_CMD+=("writers=(authenticated)")
        bashio::log.info "Auth mode 'edit' enabled for user: ${USERNAME}"
        ;;
    all)
        if [ -z "${USERNAME}" ] || [ -z "${PASSWORD}" ]; then
            bashio::log.error "Auth mode 'all' requires both username and password"
            exit 1
        fi
        TIDDLYWIKI_CMD+=("username=${USERNAME}")
        TIDDLYWIKI_CMD+=("password=${PASSWORD}")
        TIDDLYWIKI_CMD+=("readers=(authenticated)")
        TIDDLYWIKI_CMD+=("writers=(authenticated)")
        bashio::log.info "Auth mode 'all' enabled for user: ${USERNAME}"
        ;;
    *)
        bashio::log.error "Unsupported auth_mode '${AUTH_MODE}'. Use one of: none, edit, all"
        exit 1
        ;;
esac

# ------------------------------------------------------------------------------
# Configure logging
# ------------------------------------------------------------------------------
# Map add-on debug/trace to verbose TiddlyWiki runtime logging.
if bashio::config.equals 'log_level' 'debug' || bashio::config.equals 'log_level' 'trace'; then
    # Enable TiddlyWiki verbose logging for debugging
    TIDDLYWIKI_CMD+=("debug-level=verbose")
    bashio::log.debug "Verbose logging enabled"
fi

# ------------------------------------------------------------------------------
# Start TiddlyWiki server
# ------------------------------------------------------------------------------
# Log startup information
bashio::log.info "Starting TiddlyWiki server..."
bashio::log.info "Listening on: 0.0.0.0:8080"
bashio::log.info "Data directory: /data/wiki/"
bashio::log.info "Access URL: use Home Assistant 'Open Web UI' or configured host port mapping"

# Add a small delay to ensure logging is visible
sleep 1

# Start TiddlyWiki with error handling
# Note: exec replaces the shell process with TiddlyWiki for proper signal handling
# Build a redacted command view for logs (never expose password values).
LOG_CMD=()
for arg in "${TIDDLYWIKI_CMD[@]}"; do
    if [[ "${arg}" == password=* ]]; then
        LOG_CMD+=("password=***REDACTED***")
    else
        LOG_CMD+=("${arg}")
    fi
done

bashio::log.info "Executing: ${LOG_CMD[*]}"
bashio::log.debug "Command args: ${LOG_CMD[*]}"
exec "${TIDDLYWIKI_CMD[@]}"
