# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2026-04-16

### Changed
- Enabled Home Assistant ingress (`ingress: true`, `ingress_port: 8080`) for add-on access through HA UI routing.
- Expanded operator troubleshooting and regression guidance for auth modes, port mapping, ingress, and log-signature triage.

## [1.0.2] - 2026-04-16

### Changed
- Default host port mapping for `8080/tcp` is now enabled to reduce first-run setup friction.
- Added `auth_mode` configuration with three access modes:
  - `none`: no authentication needed
  - `edit`: authentication required for writes only
  - `all`: authentication required for reads and writes
- Updated runtime auth logic and documentation to match the new auth mode model.

## [1.0.1] - 2026-04-16

### Changed
- Runtime command execution now uses a safe Bash argument array for reliable credential handling.
- Container runtime is fixed to internal port `8080`; host port remapping is handled by Home Assistant network mapping.
- Build workflow now derives GHCR namespace from repository owner and builds all declared architectures.
- Docker image now pins TiddlyWiki to version `5.3.6` for reproducible builds.
- Startup ownership handling avoids recursive `chown` on every boot.
- Documentation was consolidated and outdated operational documents were removed.
- Placeholder add-on assets and maintainer operations documents were added.
- CI now includes runtime contract checks and additional pinned workflow actions.

## [1.0.0] - 2024-11-14

### Added
- Initial release of TiddlyWiki Home Assistant Add-on
- Multi-architecture support (amd64, armhf, armv7, aarch64, i386)
- Server-side saving with automatic persistence
- Optional HTTP authentication (username/password)
- Configurable host-side port mapping (container listens on 8080)
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
- Uses pinned TiddlyWiki version in current builds
- Bashio integration for configuration management
- Proper signal handling with exec
- Robust error handling and logging

[1.0.0]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.0
[1.0.1]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.1
[1.0.2]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.2
[1.0.3]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.3
