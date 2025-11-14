# TiddlyWiki Home Assistant Add-on v1.0.0

**Initial Production Release** 🎉

A production-ready Home Assistant add-on that runs TiddlyWiki as a web server with automatic server-side saving. Perfect for documentation, notes, task management, and knowledge organization within your smart home ecosystem.

## 🌟 Key Features

### Core Functionality
- ✅ **Server-side saving** - All changes automatically persisted to disk
- ✅ **Multi-architecture support** - Works on all Home Assistant platforms (amd64, armhf, armv7, aarch64, i386)
- ✅ **Zero-configuration setup** - Automatic wiki initialization on first run
- ✅ **Optional authentication** - Secure with username/password or run open for trusted networks
- ✅ **Configurable port** - Default 8080, easily changed via configuration

### Pre-installed Plugins
- **tiddlywiki/tiddlyweb** - Server-side saving support
- **tiddlywiki/filesystem** - File system integration
- **tiddlywiki/highlight** - Syntax highlighting for code blocks
- **tiddlywiki/markdown** - Full markdown support in tiddlers
- **tiddlywiki/codemirror** - Advanced code editor with syntax highlighting

### Home Assistant Integration
- ✅ **"Open Web UI" button** - One-click access from HA interface
- ✅ **Watchdog monitoring** - Automatic restart on crashes
- ✅ **Backup integration** - Included in Home Assistant backups automatically
- ✅ **Share directory access** - Easy file sharing between addons
- ✅ **Health monitoring** - Real-time status tracking

### User Experience
- 🎨 Professional addon icon and branding
- 📚 Comprehensive documentation (219 lines)
- 🚀 Welcome tiddler with getting started guide
- ⚙️ Simple configuration through Home Assistant UI
- 🔒 Security warnings for open access configurations

## 📦 Installation

1. In Home Assistant, navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the **⋮** menu (three dots) in the top right corner
3. Select **Repositories**
4. Add this repository URL: `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`
5. Find **TiddlyWiki** in the add-on list
6. Click **Install**
7. Configure (if needed) and click **Start**
8. Access your wiki via the "Open Web UI" button or `http://homeassistant.local:8080`

## ⚙️ Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `port` | `8080` | Port for the web interface |
| `username` | `""` (empty) | Username for authentication (leave empty to disable) |
| `password` | `""` (empty) | Password for authentication (leave empty to disable) |
| `log_level` | `"info"` | Logging level: trace, debug, info, notice, warning, error, fatal |

## 🔧 Technical Details

- **Base Images**: Home Assistant Alpine Linux 3.20
- **TiddlyWiki Version**: Latest stable (auto-updated on rebuild)
- **Container Size**: ~576KB (optimized)
- **Configuration Management**: Bashio integration
- **Process Management**: Proper signal handling with exec
- **Security**: No hardcoded secrets, optional authentication, input validation

## 📝 What's New in v1.0.0

### Added
- Initial production release
- Multi-architecture Docker images built and published to GHCR
- Automatic wiki initialization with welcome content
- Optional HTTP authentication (username/password)
- Configurable port and log levels
- Pre-configured with 5 essential TiddlyWiki plugins
- Watchdog for automatic restart on crashes
- Web UI integration with Home Assistant
- Backup and share directory mappings
- Comprehensive documentation (README, CHANGELOG, PRE_TEST_CHECKLIST)
- Professional addon icon and logo

### Technical Improvements
- Robust error handling throughout startup script
- Dynamic port configuration with HA watchdog (no hardcoded healthchecks)
- Proper bashio integration for configuration management
- Efficient Docker layer caching
- Cleanup of package caches for minimal image size
- Comprehensive inline code documentation (85+ comment lines)

## 📚 Documentation

- **User Guide**: See [tiddlywiki/README.md](tiddlywiki/README.md) for detailed usage instructions
- **Changelog**: See [CHANGELOG.md](CHANGELOG.md) for version history
- **Testing Guide**: See [PRE_TEST_CHECKLIST.md](PRE_TEST_CHECKLIST.md) for development/testing

## 🆘 Support

- 🐛 [Report Issues](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- 💡 [Request Features](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues/new)
- 🏠 [Home Assistant Community Forum](https://community.home-assistant.io/)
- 📖 [TiddlyWiki Official Documentation](https://tiddlywiki.com/)

## 🙏 Credits

Built with:
- [TiddlyWiki](https://tiddlywiki.com/) - A unique non-linear notebook for capturing, organizing and sharing complex information
- [Home Assistant](https://www.home-assistant.io/) - Open source home automation that puts local control and privacy first
- [Alpine Linux](https://alpinelinux.org/) - Security-oriented, lightweight Linux distribution

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

**Download the images:**
```bash
# All architecture images are available at:
ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/armhf-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/armv7-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/aarch64-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/i386-hassio-tiddlywiki:latest
```

**Installation via Home Assistant:**
Simply add the repository URL to your Home Assistant addon store - no manual image pulling required!
