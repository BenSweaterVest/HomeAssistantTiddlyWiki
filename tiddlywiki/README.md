# TiddlyWiki Home Assistant Add-on

A Home Assistant add-on that runs TiddlyWiki as a web server, providing a personal wiki system with automatic server-side saving.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## About

TiddlyWiki is a rich, interactive tool for manipulating complex data with structure that doesn't easily fit into conventional tools like spreadsheets or wordprocessors. This add-on runs TiddlyWiki in server mode, allowing multiple users to access and edit the wiki simultaneously with automatic saving.

**Version:** 1.0.0
**TiddlyWiki Version:** Latest stable (auto-updated on rebuild)
**Base Image:** Home Assistant Alpine 3.20

## Features

- ✅ **Server-side saving**: All changes automatically saved to disk
- ✅ **No authentication required**: Perfect for trusted home networks  
- ✅ **Persistent data**: Survives container restarts and updates
- ✅ **Latest TiddlyWiki**: Always runs the most recent stable version
- ✅ **Optional authentication**: Can be enabled for security
- ✅ **Health monitoring**: Integrated with Home Assistant monitoring
- ✅ **Multi-architecture**: Supports all Home Assistant platforms

## Installation

### Add the Repository

1. In Home Assistant, navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the **⋮** menu (three dots) in the top right corner
3. Select **Repositories**
4. Add this repository URL: `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`
5. Click **Add** then **Close**

### Install the Add-on

1. Find **TiddlyWiki** in the add-on list (refresh if needed)
2. Click on it to open the add-on details
3. Click **Install** (this may take a few minutes)
4. Once installed, configure the add-on (see Configuration section below)
5. Click **Start**
6. Access your wiki at `http://homeassistant.local:8080` (or your configured port)

## Configuration

Add-on configuration is done through the Home Assistant UI. Go to the add-on page and click the **Configuration** tab.

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `port` | integer | `8080` | Port for the web interface |
| `username` | string | `""` (empty) | Username for authentication (leave empty to disable) |
| `password` | password | `""` (empty) | Password for authentication (leave empty to disable) |
| `log_level` | list | `"info"` | Logging level: trace, debug, info, notice, warning, error, fatal |

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

- Wiki data is stored in `/data/wiki/` within the add-on container
- Includes:
  - `tiddlywiki.info` - Wiki configuration
  - `tiddlers/` - All your wiki pages (tiddlers)
- Data persists through:
  - Add-on restarts
  - Home Assistant restarts
  - Add-on updates
- **Backup Integration:**
  - Included in Home Assistant backups automatically
  - Also accessible via `/share` and `/backup` directories (mapped in config)
  - Manual backup: Copy files from Settings → System → Hardware → Storage

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

## Pre-installed Plugins

This add-on comes pre-configured with useful TiddlyWiki plugins:

- **tiddlywiki/tiddlyweb** - Server-side saving support
- **tiddlywiki/filesystem** - File system integration
- **tiddlywiki/highlight** - Syntax highlighting for code blocks
- **tiddlywiki/markdown** - Markdown support in tiddlers
- **tiddlywiki/codemirror** - Advanced code editor

You can add more plugins through the TiddlyWiki interface or by modifying `/data/wiki/tiddlywiki.info`.

## Advanced Usage

### Accessing the Data Directory

If you need direct access to your wiki files:

1. Enable SSH or Terminal add-on in Home Assistant
2. Navigate to: `/addon_data/[hash]_tiddlywiki/wiki/`
3. Your tiddlers are in the `tiddlers/` subdirectory

### Custom Plugins

To install additional plugins:

1. Access TiddlyWiki web interface
2. Go to Control Panel → Plugins → "Get more plugins"
3. Browse and install from the official plugin library
4. Changes will be saved in your data directory

### Changing the Port

If port 8080 conflicts with another service:

1. Go to add-on Configuration tab
2. Change the `port` value (e.g., `8888`)
3. Restart the add-on
4. Access at the new port

## Support

For issues, feature requests, and contributions:
- 🐛 [Report bugs](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- 💡 [Request features](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- 🏠 [Home Assistant Community](https://community.home-assistant.io/)
- 📖 [TiddlyWiki Documentation](https://tiddlywiki.com/)

## License

MIT License - see LICENSE file for details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
