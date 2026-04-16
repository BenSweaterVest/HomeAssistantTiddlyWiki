# Bugfix Session Brief

This brief is intended to speed up focused bugfix sessions.

## Current Architecture

- Runtime entrypoint: `tiddlywiki/run.sh`
- Add-on manifest: `tiddlywiki/config.yaml`
- Container build: `tiddlywiki/Dockerfile`, `tiddlywiki/build.yaml`
- CI/CD: `.github/workflows/build.yml`, `.github/workflows/lint.yml`
- User/operator docs: `README.md`, `tiddlywiki/README.md`
- Maintainer docs: `DEPLOYMENT_GUIDE.md`, `OPERATIONS.md`, `SECURITY.md`

## Highest-Risk Areas

- Home Assistant runtime validation has not yet been completed in a live HA environment.
- GHCR install success depends on image tag existence, package visibility, and `config.yaml` image path alignment.
- Home Assistant add-on metadata uses static Web UI and watchdog port declarations, which limits safe support for a configurable internal service port.

## Reproduction Targets

- Install add-on from repository in Home Assistant.
- Start add-on and confirm `Open Web UI` works.
- Validate anonymous mode and authenticated mode.
- Test credentials with spaces or special characters.
- Change host port mapping and confirm access still works.
- Restart add-on and confirm persistence.
- Confirm watchdog behavior after forced stop or failed start.

## File Ownership Map

- Runtime behavior: `tiddlywiki/run.sh`
- Add-on metadata and image source: `tiddlywiki/config.yaml`
- Packaging and runtime dependencies: `tiddlywiki/Dockerfile`
- Build/publish pipeline: `.github/workflows/build.yml`
- Lint/smoke validation: `.github/workflows/lint.yml`
- End-user support guidance: `tiddlywiki/README.md`, `TROUBLESHOOTING_403.md`
- Maintainer operations: `DEPLOYMENT_GUIDE.md`, `OPERATIONS.md`

## Known Constraints

- Internal port configurability is constrained by Home Assistant static manifest fields for Web UI and watchdog behavior.
- Forks publishing to their own GHCR namespace must update `tiddlywiki/config.yaml` `image:` to match that namespace.
- Architecture support is best-effort across all declared targets.

## Suggested Bugfix Order

1. Reproduce issue in Home Assistant.
2. Capture exact logs and runtime state.
3. Confirm whether the problem is runtime, manifest, or publishing related.
4. Fix the smallest layer that resolves the issue.
5. Re-run the relevant install/start/auth/persistence checks.
