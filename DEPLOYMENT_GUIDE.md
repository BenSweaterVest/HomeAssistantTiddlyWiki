# Complete Deployment Guide for TiddlyWiki Home Assistant Add-on

This guide walks you through the complete process of deploying your addon so users can install it.

## 📋 Prerequisites Checklist

Before deployment:
- ✅ All code is committed and pushed to feature branch
- ✅ All tests pass (YAML validation, bash syntax, etc.)
- ✅ Documentation is complete
- ✅ LICENSE file is present
- ✅ CHANGELOG.md is updated
- ✅ Icon and logo files exist

## 🚀 Deployment Steps

### Step 1: Create Main Branch

**Currently your repo has NO main branch!** This is why images aren't built.

```bash
# Option A: Create main from current feature branch
git checkout claude/review-previous-work-011CUuddWCWqDdX3EGaRui9T
git checkout -b main
git push -u origin main

# Option B: Via GitHub UI
# Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki
# Click branch dropdown, type "main", click "Create branch: main"
```

### Step 2: Trigger GitHub Actions Build

Once main branch exists, GitHub Actions will automatically build:

**Monitor the build:**
```
https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
```

**What gets built:**
- ✅ amd64-hassio-tiddlywiki
- ✅ armhf-hassio-tiddlywiki
- ✅ armv7-hassio-tiddlywiki
- ✅ aarch64-hassio-tiddlywiki
- ✅ i386-hassio-tiddlywiki

**Build time:** ~5-10 minutes for all architectures

**Build artifacts:** Docker images pushed to GHCR

### Step 3: Make Packages Public (CRITICAL!)

**By default, GHCR packages are PRIVATE.** You must make them public:

1. **Navigate to packages:**
   ```
   https://github.com/BenSweaterVest?tab=packages
   ```

2. **For EACH of the 5 packages:**

   a. Click package name (e.g., `amd64-hassio-tiddlywiki`)

   b. Click "Package settings" (right sidebar)

   c. Scroll to "Danger Zone" section

   d. Click "Change visibility"

   e. Select "Public"

   f. Type package name to confirm

   g. Click "I understand, change package visibility"

3. **Verify all 5 packages show "Public" badge**

**Alternative: Automate with GitHub CLI (Advanced)**

```bash
# Install GitHub CLI if needed
# brew install gh  # macOS
# apt install gh   # Linux

# Login
gh auth login

# Make packages public (run for each architecture)
gh api \
  --method PATCH \
  -H "Accept: application/vnd.github+json" \
  /user/packages/container/amd64-hassio-tiddlywiki/versions/latest \
  -f visibility='public'

# Repeat for: armhf, armv7, aarch64, i386
```

### Step 4: Verify Images Are Accessible

Test pulling an image:

```bash
# Should work without authentication now
docker pull ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:latest

# Check image exists
docker images | grep tiddlywiki
```

### Step 5: Create GitHub Release (Optional but Recommended)

```bash
# Create and push tag
git tag -a v1.0.0 -m "Release v1.0.0 - Initial production release"
git push origin v1.0.0
```

Then via GitHub UI:
1. Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/new
2. Choose tag `v1.0.0`
3. Title: `v1.0.0 - TiddlyWiki Home Assistant Add-on`
4. Copy content from `RELEASE_NOTES_v1.0.0.md`
5. Check "Set as the latest release"
6. Click "Publish release"

### Step 6: Test Installation in Home Assistant

1. **Add Repository:**
   - Settings → Add-ons → Add-on Store
   - Click ⋮ menu → Repositories
   - Add: `https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki`

2. **Install Addon:**
   - Find "TiddlyWiki" in addon list
   - Click to open details
   - Click "Install"
   - Should download images successfully (no 403 errors!)

3. **Configure & Start:**
   - Set any desired configuration
   - Click "Start"
   - Click "Open Web UI"
   - Verify TiddlyWiki loads

## 🔍 Troubleshooting

### Build Never Starts

**Problem:** Pushed to main but no build triggered

**Solutions:**
- Verify push actually went to `main` branch
- Check `.github/workflows/build.yml` exists
- Check Actions tab is enabled in repository settings
- Try manual trigger: Actions → Build TiddlyWiki Add-on → Run workflow

### Build Fails

**Common issues:**

1. **"Target directory not found"**
   - Verify `tiddlywiki/` directory exists
   - Check `--target tiddlywiki` in build.yml

2. **"Base image not found"**
   - Check internet connectivity from GitHub Actions
   - Verify base image tags in `build.yaml` are current

3. **"Permission denied"**
   - Check repository has Actions enabled
   - Verify GITHUB_TOKEN has packages:write permission

### Still Getting 403 After Build

**Most common cause:** Packages are still private!

**Fix:**
1. Go to https://github.com/BenSweaterVest?tab=packages
2. Verify all 5 packages show "Public" badge
3. If not, follow Step 3 above to make them public

**Other causes:**
- Package names don't match (check for typos)
- Wrong registry URL in config.yaml
- Caching issue (wait a few minutes, try again)

### Images Build but HA Can't Find Them

**Check:**
1. Package visibility is public
2. Image names in config.yaml match actual package names
3. Architecture is correct for your HA installation
4. Repository URL is added correctly to HA

## 📊 Deployment Checklist

Use this checklist for each deployment:

### Pre-Deployment
- [ ] All changes committed
- [ ] All tests pass
- [ ] Version bumped in config.yaml
- [ ] CHANGELOG.md updated
- [ ] Documentation reviewed

### Build Phase
- [ ] Main branch exists
- [ ] Pushed to main branch
- [ ] GitHub Actions triggered
- [ ] Build completed successfully
- [ ] All 5 architectures built
- [ ] Images appear in Packages tab

### Visibility Phase
- [ ] amd64-hassio-tiddlywiki is public
- [ ] armhf-hassio-tiddlywiki is public
- [ ] armv7-hassio-tiddlywiki is public
- [ ] aarch64-hassio-tiddlywiki is public
- [ ] i386-hassio-tiddlywiki is public

### Testing Phase
- [ ] Can manually pull images with docker
- [ ] Repository adds successfully in HA
- [ ] Addon appears in HA addon store
- [ ] Addon installs without errors
- [ ] Addon starts successfully
- [ ] Web UI accessible
- [ ] Wiki functions correctly

### Release Phase (Optional)
- [ ] Git tag created
- [ ] Tag pushed to GitHub
- [ ] GitHub release created
- [ ] Release notes published
- [ ] Release marked as latest

## 🎯 Quick Reference

### Essential URLs

- **Repository:** https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki
- **Actions:** https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
- **Packages:** https://github.com/BenSweaterVest?tab=packages
- **Releases:** https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases

### Image URLs (After Build)

```
ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/armhf-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/armv7-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/aarch64-hassio-tiddlywiki:latest
ghcr.io/bensweetervest/i386-hassio-tiddlywiki:latest
```

### Key Commands

```bash
# Create main and push
git checkout -b main
git push -u origin main

# Check build status
# Visit: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions

# Test image pull
docker pull ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:latest

# View packages
# Visit: https://github.com/BenSweaterVest?tab=packages
```

## 📝 Notes

- **First deployment takes longest** - subsequent builds are cached
- **Making packages public is MANUAL** - must be done via UI for each package
- **Architecture names must match exactly** - case-sensitive
- **Latest tag is automatic** - created by builder along with version tags
- **Users only need repository URL** - HA handles image pulling automatically

## 🎉 Success Criteria

Your addon is successfully deployed when:
1. ✅ All 5 architecture images exist in GHCR
2. ✅ All 5 packages are marked "Public"
3. ✅ You can install via Home Assistant without errors
4. ✅ The addon starts and functions correctly
5. ✅ Users can add your repository URL and install

---

**Need Help?**
- See `TROUBLESHOOTING_403.md` for 403 error fixes
- Check GitHub Actions logs for build errors
- Verify package settings if images exist but aren't accessible
