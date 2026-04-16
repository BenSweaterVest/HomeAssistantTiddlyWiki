# Operations Runbook

This runbook is for maintainers operating the add-on repository and release process.

## Release Ownership

- Releases are maintainer-owned.
- Releases are created manually on an as-needed cadence.

## Pre-Release Checklist

- Confirm `CHANGELOG.md` reflects user-visible changes.
- Confirm `tiddlywiki/config.yaml` version is updated.
- Confirm CI is passing.
- Confirm GHCR images were published for expected architectures.
- Confirm package visibility is correct for Home Assistant installs.

## Live Validation Checklist

- Add repository in Home Assistant successfully.
- Install succeeds without GHCR permission errors.
- Add-on starts successfully.
- `Open Web UI` works.
- Authentication works with and without special characters.
- Wiki data persists across restart.
- Host port remap works when changed in Home Assistant Network settings.

## Rollback

- Revert the failing change on `main`, or publish a patched release.
- If the problem is release-specific, verify the tag and GHCR package state.
- If GHCR images are wrong for a release, publish corrected images before announcing availability.

## Forking Notes

- The official add-on manifest points to the official GHCR namespace.
- Forks that publish under a different owner must update `tiddlywiki/config.yaml` `image:` to match their own package namespace.

## Support Policy

- Home Assistant support target: latest release and previous minor train.
- CPU architecture coverage is best-effort across all declared architectures.
