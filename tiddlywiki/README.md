# TiddlyWiki Home Assistant Add-on

A Home Assistant add-on that runs TiddlyWiki as a web server, providing a personal wiki system with automatic server-side saving.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## About

TiddlyWiki is a rich, interactive tool for manipulating complex data with structure that doesn't easily fit into conventional tools like spreadsheets or wordprocessors. This add-on runs TiddlyWiki in server mode, allowing multiple users to access and edit the wiki simultaneously with automatic saving.

## Features

- ✅ **Server-side saving**: All changes automatically saved to disk
- ✅ **No authentication required**: Perfect for trusted home networks  
- ✅ **Persistent data**: Survives container restarts and updates
- ✅ **Latest TiddlyWiki**: Always runs the most recent stable version
- ✅ **Optional authentication**: Can be enabled for security
- ✅ **Health monitoring**: Integrated with Home Assistant monitoring
- ✅ **Multi-architecture**: Supports all Home Assistant platforms

## Installation

1. Navigate to the Home Assistant add-on store
2. Add this repository: `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`
3. Find and install the "TiddlyWiki" add-on
4. Configure options (see below)
5. Start the add-on
6. Access via `http://homeassistant.local:8080`

## Configuration

```yaml
port: 8080              # Port for the web interface
username: ""            # Username (leave empty for no auth)
password: ""            # Password (leave empty for no auth)
log_level: "info"       # Log level: trace, debug, info, notice, warning, error, fatal
```

### Example Configuration

**No Authentication (Default):**
```yaml
port: 8080
username: ""
password: ""
log_level: "info"
```

**With Authentication:**
```yaml
port: 8080
username: "admin"
password: "your-secure-password"
log_level: "info"
```

## Usage

1. Start the add-on from the Home Assistant interface
2. Navigate to `http://homeassistant.local:8080` (or your custom port)
3. Begin creating tiddlers - all changes save automatically
4. Access from any device on your network

## Data Persistence

- Wiki data is stored in `/data/wiki/` within the add-on
- Data persists through:
  - Add-on restarts
  - Home Assistant restarts  
  - Add-on updates
- Integrates with Home Assistant's backup system

## Troubleshooting

### Add-on won't start
- Check the logs in the add-on interface
- Ensure the configured port isn't in use
- Verify Home Assistant has sufficient resources

### Can't access the wiki
- Confirm the add-on is running (green status)
- Check your firewall settings
- Try accessing via IP: `http://[ha-ip-address]:8080`

### Changes not saving
- Check add-on logs for error messages
- Ensure adequate disk space is available
- Restart the add-on if needed

## Support

For issues, feature requests, and contributions:
- 🐛 [Report bugs](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- 💡 [Request features](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- 🏠 [Home Assistant Community](https://community.home-assistant.io/)

## License

MIT License - see LICENSE file for details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
