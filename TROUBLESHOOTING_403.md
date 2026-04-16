# Troubleshooting GHCR 403 Errors

Typical error:

`denied: Head https://ghcr.io/v2/<owner>/<arch>-hassio-tiddlywiki/manifests/<tag>`

## Common Causes

1. The requested image tag does not exist.
2. Package visibility is private.
3. The image namespace in GHCR does not match the add-on `image` value.

## Fix Checklist

1. Confirm GitHub Actions build succeeded in `Actions`.
2. Confirm the expected tags exist in GHCR for all architectures.
3. Confirm package visibility is public if Home Assistant requires unauthenticated pull.
4. Confirm `tiddlywiki/config.yaml` image path matches the published namespace and naming convention.

## Verify with Docker

Run from any machine with Docker:

```bash
docker pull ghcr.io/<owner-lowercase>/amd64-hassio-tiddlywiki:<tag>
```

If this pull fails, Home Assistant installation will fail as well.

## Related Files

- Build workflow: `.github/workflows/build.yml`
- Add-on image config: `tiddlywiki/config.yaml`
- Deployment runbook: `DEPLOYMENT_GUIDE.md`
