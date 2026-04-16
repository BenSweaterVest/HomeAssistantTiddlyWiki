# Deployment Guide

This guide is for maintainers publishing new add-on versions.

## Prerequisites

- Changes merged to `main`
- Version updated in `tiddlywiki/config.yaml`
- `CHANGELOG.md` updated
- GitHub Actions enabled for the repository

## Build and Publish

1. Push to `main` (or push a `v*` tag) to trigger `.github/workflows/build.yml`.
2. Confirm successful builds in GitHub Actions.
3. Confirm all architecture images are available in GHCR.

The workflow publishes to:

- `ghcr.io/<repo-owner-lowercase>/amd64-hassio-tiddlywiki`
- `ghcr.io/<repo-owner-lowercase>/aarch64-hassio-tiddlywiki`
- `ghcr.io/<repo-owner-lowercase>/armhf-hassio-tiddlywiki`
- `ghcr.io/<repo-owner-lowercase>/armv7-hassio-tiddlywiki`
- `ghcr.io/<repo-owner-lowercase>/i386-hassio-tiddlywiki`

For the official repository, `tiddlywiki/config.yaml` points to the official GHCR namespace. If a fork publishes under a different owner, the fork must update `image:` in `tiddlywiki/config.yaml` before the add-on can install from that namespace.

## Package Visibility

If users see GHCR 403 errors, verify package visibility in GitHub Packages.  
Packages may default to private and must be public for unauthenticated pulls from Home Assistant environments.

## Release

1. Create and push a version tag (for example `v1.0.1`).
2. Publish a GitHub release with notes linked to `CHANGELOG.md`.
3. Validate install on at least one Home Assistant instance before announcing release availability.

Releases are maintainer-owned and performed manually on an as-needed cadence.

## Post-Release Validation

- Add-on appears in Home Assistant repository list
- Installation succeeds without GHCR pull errors
- Add-on starts and `Open Web UI` is reachable
- Authentication works with special characters in credentials
- Host port remapping works via add-on Network settings
- Validation on non-amd64 architectures is best-effort unless a maintainer explicitly tests them
