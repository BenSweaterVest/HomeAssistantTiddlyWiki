# TiddlyWiki Home Assistant Add-on

A Home Assistant add-on that runs TiddlyWiki as a web server, providing a personal wiki system with automatic server-side saving.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## About

TiddlyWiki is a rich, interactive tool for manipulating complex data with structure that doesn't easily fit into conventional tools like spreadsheets or wordprocessors. This add-on runs TiddlyWiki in server mode, allowing multiple users to access and edit the wiki simultaneously with automatic saving.

**Version:** 1.0.2
**TiddlyWiki Version:** 5.3.6 (pinned for reproducible builds)
**Base Image:** Home Assistant Alpine 3.20

## Features

- Server-side saving: all changes are written to disk.
- Optional authentication using username/password.
- Persistent data across restarts and add-on updates.
- Pinned TiddlyWiki runtime version for predictable behavior.
- Health monitoring through Home Assistant watchdog.
- Home Assistant ingress support for access through the HA UI.
- Multi-architecture support for Home Assistant platforms.

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
6. Access your wiki via the **Open Web UI** button.
7. Optional: use the Home Assistant sidebar/add-on ingress entry when remote access policy blocks direct host ports.

## Configuration

Add-on configuration is done through the Home Assistant UI. Go to the add-on page and click the **Configuration** tab.

Note: although TiddlyWiki itself can listen on other ports, Home Assistant add-on metadata uses static port declarations for the Web UI button and watchdog checks. This add-on therefore treats container port `8080` as fixed and expects host-side remapping through Home Assistant Network settings.

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `auth_mode` | list | `"none"` | Access mode: `none` (no auth), `edit` (auth required to edit), `all` (auth required to view/edit). |
| `username` | string | `""` | Username used for `edit` and `all` auth modes. |
| `password` | password | `""` | Password used for `edit` and `all` auth modes. |
| `log_level` | list | `"info"` | Logging level: trace, debug, info, notice, warning, error, fatal. |

### Example Configuration

**No Authentication (Default):**
```yaml
auth_mode: "none"
username: ""
password: ""
log_level: "info"
```

**Authentication Required to Edit (Read is open):**
```yaml
auth_mode: "edit"
username: "admin"
password: "your-secure-password"
log_level: "info"
```

**Authentication Required to View and Edit:**
```yaml
auth_mode: "all"
username: "admin"
password: "your-secure-password"
log_level: "info"
```

## Usage

1. Start the add-on from the Home Assistant interface
2. Open **Web UI** from the add-on page, or browse to your Home Assistant host and mapped port.
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
- Ensure the mapped host port is not in use
- Verify Home Assistant has sufficient resources

### Can't access the wiki
- Confirm the add-on is running (green status)
- Check your firewall settings
- Verify the host port mapping for container port `8080`
- If direct host access is restricted, open the add-on via Home Assistant ingress path instead.

### HTTP 401 when auth mode is enabled
- `auth_mode: "all"` requires login for both viewing and editing.
- `auth_mode: "edit"` allows viewing without login, but editing requires login.
- Some browsers show a generic error instead of a login prompt on HTTP 401.
- Retry with explicit credentials in URL form (URL-encode special characters), for example: `http://username:password@host:port/`
- Verify credentials with curl if needed:
  - `curl -I http://host:port/` should return `401` without credentials
  - `curl -I -u 'username:password' http://host:port/` should return non-401 when credentials are correct

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

TiddlyWiki always listens on container port `8080`, but you can change the host-facing port:

1. Open the add-on page in Home Assistant
2. Go to **Configuration** -> **Network**
3. Change the host port mapping for container port `8080` (default host mapping is already enabled)
4. Restart the add-on
5. Access TiddlyWiki on the new host port

## Frequently Asked Questions

### Can I use this without authentication?

Yes. Set `auth_mode: "none"` to allow open read/write access. This should only be used on trusted home networks.

Other options are:
- `auth_mode: "edit"`: anyone can read, authentication is required to edit
- `auth_mode: "all"`: authentication is required to view and edit

### How do I backup my wiki?

Your wiki is automatically included in Home Assistant backups. The data is stored in `/data/wiki/` within the add-on container. You can also:
- Use Home Assistant's built-in backup system
- Manually copy files from the data directory
- Use the `/share` and `/backup` directory mappings for external backup scripts

### Can I install custom TiddlyWiki plugins?

Absolutely! You can install additional plugins in two ways:
1. **Via Web UI:** Use TiddlyWiki's Control Panel → Plugins → "Get more plugins"
2. **Manually:** Edit `/data/wiki/tiddlywiki.info` to add plugin references

All plugin installations are automatically saved and persist across restarts.

### What happens if I change the port?

The add-on exposes container port `8080`. If you remap it in **Network** settings, Home Assistant will open the add-on at the remapped host port after restart.

The "Open Web UI" button in Home Assistant will also update automatically.

### How do I migrate from standalone TiddlyWiki?

To migrate your existing TiddlyWiki:
1. Stop the add-on if it's running
2. Access the add-on data directory (via SSH/Terminal add-on)
3. Navigate to `/addon_data/[hash]_tiddlywiki/wiki/tiddlers/`
4. Copy your `.tid` files from your old TiddlyWiki to this directory
5. Restart the add-on

Your existing tiddlers will appear immediately.

### Does this support multiple wikis?

Currently, this add-on runs a single wiki instance. If you need multiple wikis, you can:
- Install the add-on multiple times (if supported by Home Assistant)
- Use different ports for each instance
- Consider using TiddlyWiki's multi-wiki features within a single instance

### What's the difference between this and file-based TiddlyWiki?

| Feature | This Add-on | File-based TiddlyWiki |
|---------|-------------|----------------------|
| Server-side saving | Automatic | Manual save required |
| Multi-user access | Simultaneous editing | One at a time |
| Backup integration | Automatic with Home Assistant backups | Manual |
| Setup complexity | One-click install | Manual configuration |
| Performance | Fast server-side | Browser-dependent |

### How much disk space does it need?

The add-on itself is approximately 50-100MB. Your wiki data grows based on content:
- Empty wiki: ~1-2MB
- Typical personal wiki: 5-20MB
- Large wiki with media: 50-500MB

Monitor your disk usage in Home Assistant's System settings.

## Support

For issues and requests:
- [GitHub Issues](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- [Home Assistant Community](https://community.home-assistant.io/)
- [TiddlyWiki Documentation](https://tiddlywiki.com/)

Support target:
- Home Assistant latest release and previous minor train
- Best-effort validation across supported CPU architectures

## License

MIT License - see LICENSE file for details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
