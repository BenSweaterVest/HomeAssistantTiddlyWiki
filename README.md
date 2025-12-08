# TiddlyWiki Home Assistant Add-on

[![Release][release-shield]][release] [![License][license-shield]](LICENSE) [![GitHub Activity][commits-shield]][commits] [![Project Maintenance][maintenance-shield]][maintainer]
[![GitHub Release][release-shield]][release]
[![License][license-shield]](LICENSE)
[![GitHub Activity][commits-shield]][commits]
[![Project Maintenance][maintenance-shield]][maintainer]
[![GitHub Issues][issues-shield]][issues]

A Home Assistant add-on that runs TiddlyWiki as a web server, providing a personal wiki system with automatic server-side saving.

[release-shield]: https://img.shields.io/github/v/release/BenSweaterVest/HomeAssistantTiddlyWiki?style=for-the-badge
[release]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases
[license-shield]: https://img.shields.io/github/license/BenSweaterVest/HomeAssistantTiddlyWiki?style=for-the-badge
[commits-shield]: https://img.shields.io/github/commit-activity/y/BenSweaterVest/HomeAssistantTiddlyWiki?style=for-the-badge
[commits]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/commits/main
[maintenance-shield]: https://img.shields.io/maintenance/yes/2024?style=for-the-badge
[maintainer]: https://github.com/BenSweaterVest
[issues-shield]: https://img.shields.io/github/issues/BenSweaterVest/HomeAssistantTiddlyWiki?style=for-the-badge
[issues]: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues

## About

TiddlyWiki is a powerful, flexible tool for organizing information. This add-on brings TiddlyWiki to Home Assistant with server-side saving, making it perfect for documentation, notes, task management, and knowledge organization within your smart home ecosystem.

## Screenshots

> 📸 **Note:** Screenshots will be added after initial deployment. The add-on provides a clean, intuitive interface with the full TiddlyWiki experience.

**Coming soon:**
- Add-on in Home Assistant Store
- Configuration UI
- TiddlyWiki interface with welcome tiddler
- Web UI integration

## Installation

**⚠️ Note:** Docker images must be built and public before installation. See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) if you're the maintainer, or wait for the first release to be published.

1. In Home Assistant, navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the **⋮** menu in the top right → **Repositories**
3. Add this repository URL: `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`
4. Find **TiddlyWiki** in the add-on list and click it
5. Click **Install**
6. Configure the add-on (see Configuration section)
7. Click **Start**

**Getting 403 errors?** See [TROUBLESHOOTING_403.md](TROUBLESHOOTING_403.md)

## Documentation

For detailed documentation, configuration options, and troubleshooting, see the [add-on documentation](tiddlywiki/README.md).

## Features

- ✅ Server-side saving - all changes automatically persisted
- ✅ Multi-architecture support (amd64, armhf, armv7, aarch64, i386)
- ✅ Optional authentication
- ✅ Pre-configured with useful plugins (markdown, syntax highlighting, CodeMirror)
- ✅ Health monitoring
- ✅ Backup integration

## Why This Add-on?

Choosing the right wiki solution for your Home Assistant setup:

| Feature | This Add-on | File-based TiddlyWiki | Other Wiki Solutions |
|---------|-------------|----------------------|---------------------|
| Server-side saving | ✅ Automatic | ❌ Manual downloads | ✅ Usually |
| No database required | ✅ File-based | ✅ Single HTML file | ❌ Requires DB |
| Multi-user support | ✅ Simultaneous editing | ❌ Single user | ✅ Usually |
| Home Assistant integration | ✅ Native add-on | ❌ Manual setup | ⚠️ Varies |
| Backup integration | ✅ Automatic with HA | ❌ Manual | ⚠️ Varies |
| Resource usage | 🟢 Low | 🟢 None | 🟡 Medium-High |
| Setup complexity | 🟢 One-click | 🟡 Moderate | 🔴 Complex |
| Customization | ✅ Highly flexible | ✅ Highly flexible | ⚠️ Varies |
| Offline capable | ✅ Self-hosted | ✅ Yes | ⚠️ Depends |

**Perfect for:**
- Personal documentation and notes
- Home automation documentation
- Task and project management
- Recipe and knowledge collection
- Meeting notes and journals
- Code snippet libraries

## Support

- [Report Issues](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues)
- [Home Assistant Community Forum](https://community.home-assistant.io/)

## License

MIT License - See [LICENSE](LICENSE) for details.
