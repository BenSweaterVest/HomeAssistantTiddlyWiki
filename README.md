# TiddlyWiki Home Assistant Add-on

Home Assistant add-on that runs TiddlyWiki in server mode with persistent storage and optional HTTP authentication.

## Installation

1. In Home Assistant, open **Settings -> Add-ons -> Add-on Store**.
2. Open **Repositories** and add `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`.
3. Select **TiddlyWiki** and install.
4. Start the add-on and use **Open Web UI**.

If installation fails with GHCR permissions or image-tag errors, see `TROUBLESHOOTING_403.md`.

## Key Features

- Server-side saving with persistent `/data/wiki` storage.
- Optional username/password authentication.
- Multi-architecture images (`amd64`, `aarch64`, `armhf`, `armv7`, `i386`).
- Health monitoring through Home Assistant watchdog integration.

## Port Behavior

The container listens on internal port `8080`.  
If you need a different external port, change the host mapping in the add-on **Configuration -> Network** page.

Home Assistant add-on manifests define static port mappings for `webui` and watchdog behavior. Because of that, this project currently treats the internal service port as fixed even though the runtime itself could listen elsewhere.

## Support Window

This project is maintained on a best-effort basis.

- Supported Home Assistant versions: latest release and previous minor train.
- Supported CPU architectures: `amd64`, `aarch64`, `armhf`, `armv7`, `i386`.
- Architecture support is best-effort across all targets.

## Documentation

- User and operator guide: `tiddlywiki/README.md`
- Contributor workflow: `CONTRIBUTING.md`
- Deployment process: `DEPLOYMENT_GUIDE.md`
- Maintainer operations runbook: `OPERATIONS.md`
- Security reporting policy: `SECURITY.md`
- Version history: `CHANGELOG.md`

## Support

- Issues: [GitHub Issues](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- Community: [Home Assistant Community Forum](https://community.home-assistant.io/)

## License

MIT. See `LICENSE`.
