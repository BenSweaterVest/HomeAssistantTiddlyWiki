# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-14

### Added
- Initial release of TiddlyWiki Home Assistant Add-on
- Multi-architecture support (amd64, armhf, armv7, aarch64, i386)
- Server-side saving with automatic persistence
- Optional HTTP authentication (username/password)
- Configurable port (default: 8080)
- Configurable log levels (trace, debug, info, notice, warning, error, fatal)
- Pre-configured with useful plugins:
  - tiddlywiki/tiddlyweb (server-side saving)
  - tiddlywiki/filesystem (file system integration)
  - tiddlywiki/highlight (syntax highlighting)
  - tiddlywiki/markdown (markdown support)
  - tiddlywiki/codemirror (code editor)
- Automatic wiki initialization with welcome tiddler
- Health check monitoring
- Watchdog for automatic restart on crashes
- Web UI integration with Home Assistant
- Backup and share directory mappings
- Comprehensive documentation

### Technical Details
- Based on Home Assistant Alpine 3.20 base images
- Uses latest stable TiddlyWiki version
- Bashio integration for configuration management
- Proper signal handling with exec
- Robust error handling and logging

[1.0.0]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.0
