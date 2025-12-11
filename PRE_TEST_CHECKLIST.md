# Pre-Test Checklist for TiddlyWiki Home Assistant Add-on

## File Structure Verification

- [ ] All required files present:
  ```
  ├── .github/workflows/build.yml
  ├── CHANGELOG.md
  ├── LICENSE
  ├── README.md
  ├── repository.yaml
  └── tiddlywiki/
      ├── Dockerfile
      ├── README.md
      ├── build.yaml
      ├── config.yaml
      ├── icon.png (256x256)
      ├── logo.png (256x256)
      └── run.sh
  ```

- [ ] No extra/unwanted files in repository

## Configuration Validation

### config.yaml
- [ ] All required fields present (name, version, slug, description, url, arch, image)
- [ ] `webui` field configured: `http://[HOST]:[PORT:8080]`
- [ ] `watchdog` field configured: `tcp://[HOST]:[PORT:8080]`
- [ ] Port schema uses `port` type
- [ ] Username/password are optional (`str?` and `password?`)
- [ ] Log level list includes all valid options
- [ ] Image reference matches GHCR format: `ghcr.io/bensweetervest/{arch}-hassio-tiddlywiki`
- [ ] YAML syntax is valid

### build.yaml
- [ ] All 5 architectures defined (amd64, armhf, armv7, aarch64, i386)
- [ ] Base images use Alpine 3.20
- [ ] OCI labels include title, description, source, licenses
- [ ] YAML syntax is valid

### repository.yaml
- [ ] Name, URL, and maintainer fields present
- [ ] GitHub URL is correct
- [ ] YAML syntax is valid

## Code Quality

### Dockerfile
- [ ] Uses ARG for BUILD_FROM, BUILD_ARCH, BUILD_VERSION
- [ ] Base image FROM ${BUILD_FROM}
- [ ] Node.js and npm installed
- [ ] TiddlyWiki installed globally with npm
- [ ] Package caches cleaned (apk, tmp, npm)
- [ ] run.sh copied and made executable
- [ ] Data directory created (/data/wiki)
- [ ] All required labels present
- [ ] No HEALTHCHECK directive (using watchdog instead)
- [ ] EXPOSE 8080
- [ ] CMD ["/run.sh"]

### run.sh
- [ ] Shebang: `#!/usr/bin/with-contenv bashio`
- [ ] shellcheck directive present
- [ ] `set -e` for fail-fast behavior
- [ ] Loads all config variables (PORT, USERNAME, PASSWORD, LOG_LEVEL)
- [ ] Sets log level with bashio
- [ ] Creates /data/wiki directory
- [ ] Initializes TiddlyWiki if not exists
- [ ] Creates welcome tiddler
- [ ] Verifies TiddlyWiki installation
- [ ] Builds command with proper port configuration
- [ ] Handles authentication conditionally
- [ ] Handles debug logging
- [ ] Uses `exec` to replace shell process
- [ ] All variables properly quoted
- [ ] Bash syntax is valid

## GitHub Actions

### build.yml
- [ ] Triggers on push to `main` branch
- [ ] Includes `workflow_dispatch` for manual trigger
- [ ] Registry set to `ghcr.io`
- [ ] Uses `actions/checkout@v4`
- [ ] Uses `docker/login-action@v3` for GHCR
- [ ] Authenticates with `secrets.GITHUB_TOKEN`
- [ ] Uses `home-assistant/builder@master`
- [ ] Build target set to `tiddlywiki` (not /data/tiddlywiki)
- [ ] Builds all architectures with `--all`
- [ ] Docker hub set to `ghcr.io/bensweetervest`
- [ ] Proper permissions (contents:read, packages:write)

## Documentation

### README.md (Root)
- [ ] Project title and description
- [ ] Badges (release, license)
- [ ] Installation instructions
- [ ] Feature list
- [ ] Link to detailed documentation
- [ ] Support links

### tiddlywiki/README.md
- [ ] About section
- [ ] Version information
- [ ] Feature list with checkmarks
- [ ] Installation steps (repository + addon)
- [ ] Configuration table with all options
- [ ] Example configurations
- [ ] Usage instructions
- [ ] Data persistence explanation
- [ ] Troubleshooting section
- [ ] Pre-installed plugins list
- [ ] Advanced usage examples
- [ ] Support and documentation links
- [ ] Architecture badges

### CHANGELOG.md
- [ ] Follows Keep a Changelog format
- [ ] Version 1.0.0 entry
- [ ] All features listed
- [ ] Technical details included
- [ ] Release link structure

### LICENSE
- [ ] Complete MIT license text
- [ ] Correct copyright year (2024)
- [ ] Correct copyright holder name

## Asset Files

### icon.png & logo.png
- [ ] Both files exist in tiddlywiki/ directory
- [ ] 256x256 pixels
- [ ] PNG format
- [ ] File size reasonable (< 10KB)
- [ ] Visually appropriate for addon

## Common Build Failure Checks

### If Build Fails in GitHub Actions:

1. **Check Target Path**
   - Ensure `--target tiddlywiki` (not `/data/tiddlywiki`)
   - Target should match actual directory name

2. **Check Image References**
   - config.yaml `image` field should match docker-hub parameter
   - Format: `ghcr.io/[username]/{arch}-[addon-name]`

3. **Check File Permissions**
   - run.sh should be executable in repository (git tracks this)
   - Check with: `git ls-files -s tiddlywiki/run.sh`
   - Should show mode 100755 or 100644 (chmod happens in Dockerfile)

4. **Check for Typos**
   - Repository name in all files
   - GitHub username casing (bensweetervest vs BenSweaterVest)
   - Addon slug matches everywhere

5. **Check Authentication**
   - GITHUB_TOKEN has packages:write permission
   - GitHub Actions enabled for repository

6. **Check Syntax**
   - All YAML files valid: `python3 -c "import yaml; yaml.safe_load(open('FILE'))"`
   - Bash script valid: `bash -n tiddlywiki/run.sh`
   - Dockerfile valid: Look for syntax errors

7. **Check Image Base**
   - Base images in build.yaml are accessible
   - Current: `ghcr.io/home-assistant/[arch]-base:3.20`

## Manual Testing Steps

### Local YAML Validation
```bash
# From project root
python3 -c "import yaml; yaml.safe_load(open('tiddlywiki/config.yaml')); print('✓ config.yaml')"
python3 -c "import yaml; yaml.safe_load(open('tiddlywiki/build.yaml')); print('✓ build.yaml')"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/build.yml')); print('✓ build.yml')"
python3 -c "import yaml; yaml.safe_load(open('repository.yaml')); print('✓ repository.yaml')"
```

### Bash Script Validation
```bash
cd tiddlywiki && bash -n run.sh && echo "✓ run.sh syntax valid"
```

### File Existence Check
```bash
ls -lh tiddlywiki/icon.png tiddlywiki/logo.png
```

### Check File Modes
```bash
git ls-files -s | grep run.sh
```

## Pre-Commit Checklist

Before committing changes:
- [ ] All files validated
- [ ] No debug code or TODOs
- [ ] All changes documented in commit message
- [ ] Version number appropriate
- [ ] CHANGELOG.md updated if needed

## Pre-Push Checklist

Before pushing to GitHub:
- [ ] All commits have clear messages
- [ ] No sensitive information in commits
- [ ] Branch name follows convention (claude/*)
- [ ] Ready for PR or direct merge

## Post-Push Verification

After pushing:
- [ ] GitHub Actions workflow starts (for main branch)
- [ ] Build completes successfully
- [ ] Images appear in GitHub Packages
- [ ] Images tagged correctly with architectures

## Installation Testing

After successful build:
- [ ] Add repository to Home Assistant
- [ ] Addon appears in addon store
- [ ] Icon displays correctly
- [ ] Installation completes
- [ ] Configuration UI works
- [ ] Addon starts successfully
- [ ] Web UI opens
- [ ] Port configuration works
- [ ] Authentication works (if enabled)
- [ ] Data persists after restart
- [ ] Backup includes addon data

## Post-Installation Verification

- [ ] Check addon logs for errors
- [ ] Verify TiddlyWiki is accessible
- [ ] Test creating/editing tiddlers
- [ ] Test saving works
- [ ] Test restart behavior
- [ ] Test different ports
- [ ] Test with and without authentication
- [ ] Test watchdog (stop addon, verify auto-restart)

---

**Last Updated:** 2024-11-14
**Version:** 1.0.0
