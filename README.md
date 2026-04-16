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
- Flexible authentication modes: no auth, auth-to-edit, or auth-to-view-and-edit.
- Multi-architecture images (`amd64`, `aarch64`, `armhf`, `armv7`, `i386`).
- Health monitoring through Home Assistant watchdog integration.
- Authentication troubleshooting guidance is included in `tiddlywiki/README.md` for HTTP 401/browser prompt edge-cases.

## Port Behavior

The container listens on internal port `8080`, and the add-on exposes host port `8080` by default.  
If you need a different external port, change the host mapping in the add-on **Configuration -> Network** page.

Home Assistant add-on manifests define static port mappings for `webui` and watchdog behavior. Because of that, this project currently treats the internal service port as fixed even though the runtime itself could listen elsewhere.

## Ingress vs direct port

**Default path:** use **Open Web UI** or the mapped host port (for example `http://<home-assistant-host>:8080/`). This is the primary access method for most setups.

**Ingress:** the add-on supports Home Assistant ingress so you can open it from the HA sidebar when you prefer routing through Home Assistant instead of exposing the host port. Use whichever matches your network and security policy.

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
- Bugfix session context: `BUGFIX_SESSION_BRIEF.md`
- GHCR pull issues: `TROUBLESHOOTING_403.md`
- Security reporting policy: `SECURITY.md`
- Version history: `CHANGELOG.md`

## Support

- Issues: [GitHub Issues](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- Community: [Home Assistant Community Forum](https://community.home-assistant.io/)

## License

MIT. See `LICENSE`.
