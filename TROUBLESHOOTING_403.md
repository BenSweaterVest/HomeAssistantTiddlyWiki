# Fixing the 403 GHCR Installation Error

## 🔍 Issue Analysis

**Error Message:**
```
Can't install ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:1.0.0: 403 Client Error
Forbidden ("Head "https://ghcr.io/v2/bensweetervest/amd64-hassio-tiddlywiki/manifests/1.0.0": denied")
```

## 🎯 Root Cause

**The Docker images have not been built yet!**

Here's what's happening:
1. ✅ Your code is on the feature branch: `claude/review-previous-work-011CUuddWCWqDdX3EGaRui9T`
2. ❌ **There is no `main` branch** in your repository yet
3. ❌ GitHub Actions workflow only triggers on push to `main` (see `.github/workflows/build.yml` line 5)
4. ❌ No images have been built or pushed to GHCR
5. ❌ When Home Assistant tries to pull the images, they don't exist → 403 Forbidden

**The 403 error doesn't mean "private" in this case - it means "doesn't exist"**

## ✅ Solution - Build the Images

You have two options:

### Option 1: Create Main Branch and Trigger Build (Recommended)

```bash
# 1. Checkout your feature branch
git checkout claude/review-previous-work-011CUuddWCWqDdX3EGaRui9T

# 2. Create and push main branch from current state
git checkout -b main
git push -u origin main

# 3. Wait for GitHub Actions to build (5-10 minutes)
#    Monitor at: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
```

### Option 2: Merge Feature Branch to Main via Pull Request

1. **Create `main` branch first:**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki
   - Click "Branch: claude/review..." dropdown
   - Type "main" and click "Create branch: main"

2. **Create Pull Request:**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/pulls
   - Click "New pull request"
   - Base: `main` ← Compare: `claude/review-previous-work-011CUuddWCWqDdX3EGaRui9T`
   - Click "Create pull request"
   - Click "Merge pull request"

3. **Monitor the build:**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
   - Wait for "Build TiddlyWiki Add-on" workflow to complete
   - Should take 5-10 minutes to build all 5 architectures

## 📦 After Build Completes - Make Packages Public

GitHub Container Registry packages are **private by default**. You need to make them public:

### Steps to Make Packages Public:

1. **Go to your packages:**
   ```
   https://github.com/BenSweaterVest?tab=packages
   ```

2. **For EACH architecture package** (you'll have 5):
   - Click on the package name (e.g., `amd64-hassio-tiddlywiki`)
   - Click "Package settings" (right sidebar)
   - Scroll down to "Danger Zone"
   - Click "Change visibility"
   - Select "Public"
   - Type the package name to confirm
   - Click "I understand, change package visibility"

3. **Repeat for all 5 packages:**
   - `amd64-hassio-tiddlywiki`
   - `armhf-hassio-tiddlywiki`
   - `armv7-hassio-tiddlywiki`
   - `aarch64-hassio-tiddlywiki`
   - `i386-hassio-tiddlywiki`

## 🔧 Alternative: Update Workflow to Make Packages Public Automatically

Add this to your `.github/workflows/build.yml` after the build step:

```yaml
      - name: Make package public
        if: success()
        run: |
          # Note: This requires a Personal Access Token with packages:write scope
          # For now, manually make packages public via GitHub UI
          echo "Build complete. Make packages public via GitHub UI:"
          echo "https://github.com/BenSweaterVest?tab=packages"
```

## ✅ Verification Steps

After building and making packages public:

1. **Check packages exist:**
   ```bash
   # Try to pull an image manually (from any machine)
   docker pull ghcr.io/bensweetervest/amd64-hassio-tiddlywiki:latest
   ```

2. **Verify in GitHub:**
   - Go to: https://github.com/BenSweaterVest?tab=packages
   - Should see 5 packages listed
   - Each should show "Public" badge

3. **Test in Home Assistant:**
   - Add repository URL to HA addon store
   - Refresh addon list
   - TiddlyWiki addon should appear
   - Click Install
   - Should download and install successfully

## 🐛 Troubleshooting

### Build Fails with "target not found"
- Check that `tiddlywiki/` directory exists in repository
- Verify `.github/workflows/build.yml` has `--target tiddlywiki`

### Build Succeeds but Packages Still Don't Exist
- Check GitHub Actions logs for actual completion
- Verify authentication worked (no "denied" errors in logs)
- Check packages tab: https://github.com/BenSweaterVest?tab=packages

### Packages Exist but Still Get 403
- Packages are still private - follow "Make Packages Public" steps above
- Or: Verify package names match exactly (case-sensitive)

### Build Takes Too Long
- Building 5 architectures takes time
- Typical build: 5-10 minutes total
- Check Actions tab for progress

## 📝 Current Workflow Trigger

Your workflow only builds on:
```yaml
on:
  push:
    branches: [ main ]  # ← Only triggers on push to main
  workflow_dispatch:    # ← Or manual trigger
```

**This means:**
- ❌ Pushes to feature branches don't trigger builds
- ✅ Pushes to `main` trigger automatic builds
- ✅ Manual trigger works from Actions tab (if you have a main branch)

## 🎯 Quick Fix Summary

1. **Create `main` branch** from your feature branch
2. **Push to `main`** to trigger GitHub Actions
3. **Wait for build** to complete (~5-10 minutes)
4. **Make packages public** via GitHub UI (5 packages)
5. **Test installation** in Home Assistant

## 📞 Next Steps

After following these steps, if you still get errors:
- Share the GitHub Actions build logs
- Check which step failed
- Verify package visibility settings

The images MUST be built and public before Home Assistant can install them!

---

**Quick Links:**
- Actions: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
- Packages: https://github.com/BenSweaterVest?tab=packages
- Workflow file: `.github/workflows/build.yml`
