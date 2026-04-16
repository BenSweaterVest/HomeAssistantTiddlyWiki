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

## Runtime Regression Matrix

Run this matrix before release when possible:

- `auth_mode=none`: browse and edit without credentials.
- `auth_mode=edit`: browse without credentials, verify edit/save is blocked until authenticated.
- `auth_mode=all`: verify unauthenticated access returns HTTP 401 and authenticated access works.
- Special-character password: verify with browser and `curl -u 'user:pass'`.
- Port mapping: verify default `8080` and one remapped host port.
- Ingress: verify add-on is reachable through Home Assistant ingress.
- Persistence: create/update tiddler, restart add-on, confirm data remains.

## Observability Quick Map

Use these signatures to triage quickly:

- **`Failed to get token from https://ghcr.io/token: 403`**
  - GHCR package visibility or namespace/tag mismatch.
- **`Can't install ghcr.io/... denied`**
  - Wrong owner path, private package, or missing tag.
- **`Auth mode 'edit' requires both username and password`**
  - `auth_mode` set but credentials missing.
- **`HTTP 401 Authentication required`**
  - Expected when auth is enabled and request is unauthenticated.
- **`Connection refused` on add-on port**
  - Port mapping disabled or add-on not running.

## Rollback

- Revert the failing change on `main`, or publish a patched release.
- If the problem is release-specific, verify the tag and GHCR package state.
- If GHCR images are wrong for a release, publish corrected images before announcing availability.

## Forking Notes

- The official add-on manifest points to the official GHCR namespace.
- Forks that publish under a different owner must update `tiddlywiki/config.yaml` `image:` to match their own package namespace.
- Home Assistant add-on manifests use a static `image:` field; fully automatic owner-dynamic install behavior is not supported for forks without manifest edits.

## Support Policy

- Home Assistant support target: latest release and previous minor train.
- CPU architecture coverage is best-effort across all declared architectures.

## Last live validation (record)

- **When:** 2026-04-16  
- **Where:** Home Assistant OS test VM (`haos-test`, reachable at `192.168.122.122` on the validation network).  
- **GHCR:** Public packages for all declared architectures; tags `latest` and release tags verified via GitHub Packages.  
- **Auth matrix (HTTP):** `auth_mode=none` — unauthenticated GET not challenged with `401`; `auth_mode=edit` — anonymous read not blocked at HTTP layer (validated GET vs prior `all`); `auth_mode=all` — unauthenticated GET returns `401`, authenticated GET passes auth (observed non-`401`).  
- **Not exercised in this pass (optional):** host port remap to a non-default value, explicit ingress sidebar open, persistence edit-after-restart, forced watchdog restart. Re-run those before a major release if you change networking or storage paths.
