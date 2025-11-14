# How to Create v1.0.0 Release

## Current Status

✅ **Tag created locally**: v1.0.0
✅ **Release notes prepared**: RELEASE_NOTES_v1.0.0.md
⚠️ **Tag push restricted**: Need to push from main branch

## Steps to Create the Release

### Option A: Create Release from Feature Branch (Recommended for Testing)

1. **Push the tag manually after merging to main:**
   ```bash
   # First, merge your feature branch to main via GitHub PR
   # Then checkout main locally
   git checkout main
   git pull origin main

   # Create and push the tag from main
   git tag -a v1.0.0 -m "Release v1.0.0 - Initial production release"
   git push origin v1.0.0
   ```

2. **Create the GitHub Release:**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/new
   - Click "Choose a tag" → Select `v1.0.0`
   - Release title: `v1.0.0 - TiddlyWiki Home Assistant Add-on`
   - Copy contents from `RELEASE_NOTES_v1.0.0.md` into the description
   - Check "Set as the latest release"
   - Click "Publish release"

### Option B: Create Release via GitHub Web Interface (Easiest)

**Note:** The tag is already created locally. You'll need to either:
- Merge to main first, then push the tag from main, OR
- Create the release directly from GitHub which will create the tag for you

**Steps:**

1. **Create Pull Request and Merge**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/pulls
   - Click "New pull request"
   - Base: `main` ← Compare: `claude/review-previous-work-011CUuddWCWqDdX3EGaRui9T`
   - Title: "Release v1.0.0 - Production-ready TiddlyWiki Add-on"
   - Create and merge the PR

2. **Create Release from Main**
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/new
   - In "Choose a tag" → Type `v1.0.0` and select "Create new tag: v1.0.0 on publish"
   - Target: `main`
   - Release title: `v1.0.0 - TiddlyWiki Home Assistant Add-on`
   - Description: Copy contents from `RELEASE_NOTES_v1.0.0.md`
   - Optionally attach files:
     - You can attach the built images, but not necessary for HA addons
     - Users will pull from GHCR automatically
   - Check "Set as the latest release"
   - Click "Publish release"

### Option C: Wait for GitHub Actions Build (Best Practice)

**Recommended workflow for production releases:**

1. **Merge to Main First**
   - Create and merge PR to main
   - Wait for GitHub Actions to build all architectures
   - Verify builds succeeded and images are in GHCR

2. **Then Create Release**
   - After successful build, create the release
   - This ensures the release points to tested, built code
   - Go to: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/new
   - Choose tag `v1.0.0` or create it
   - Add release notes from `RELEASE_NOTES_v1.0.0.md`
   - Publish

## What the Release Does

✅ **Creates a downloadable package** - Users can download source as .zip or .tar.gz
✅ **Creates a release page** - Professional presentation of your addon
✅ **Enables version badges** - README badges will work correctly
✅ **Provides release notes** - Users can see what's new
✅ **Creates a permanent reference** - Specific version is always available

## After Creating the Release

1. **Verify the release appears:**
   - Check: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases
   - Should show v1.0.0 with "Latest" tag

2. **Test installation:**
   - Add repository to Home Assistant
   - Verify addon appears with correct version (1.0.0)
   - Install and test functionality

3. **Share the release:**
   - The release URL will be: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/tag/v1.0.0
   - Share in Home Assistant community forum
   - Add to any addon directories/lists

## Troubleshooting

### Tag Push Failed with 403
This is normal when pushing from a feature branch. Solutions:
- **Option 1**: Merge to main first, then push tag from main
- **Option 2**: Create tag directly from GitHub release interface
- **Option 3**: Delete local tag and recreate after merging
  ```bash
  git tag -d v1.0.0
  git checkout main
  git pull
  git tag -a v1.0.0 -m "Release message"
  git push origin v1.0.0
  ```

### Release Not Showing as "Latest"
- Make sure you checked "Set as the latest release"
- Edit the release and check the box
- Older releases won't auto-update to latest

### README Badges Not Working
- Badges need the release to exist first
- After creating release, badges should work within a few minutes
- Clear browser cache if needed

## Files Ready for Release

- ✅ `RELEASE_NOTES_v1.0.0.md` - Comprehensive release notes
- ✅ `CHANGELOG.md` - Version history
- ✅ `README.md` - Project documentation
- ✅ `tiddlywiki/README.md` - Addon documentation
- ✅ `LICENSE` - MIT license
- ✅ Tag created locally: `v1.0.0`

## Next Steps

1. Choose your preferred option (A, B, or C above)
2. Follow the steps for that option
3. Verify the release appears on GitHub
4. Test installation in Home Assistant
5. Share with the community!

---

**Quick Links:**
- Create Release: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases/new
- Create PR: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/compare
- View Releases: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/releases
- View Actions: https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/actions
