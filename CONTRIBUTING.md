# Contributing

Thank you for contributing to this project.

## Scope

Contributions are welcome for bug fixes, documentation improvements, tests, and operational hardening.

## Workflow

1. Open or confirm an issue for the change.
2. Create a branch from `main`.
3. Implement the change with tests or verification notes.
4. Open a pull request with a clear problem statement and impact summary.

## Support Policy

- Home Assistant support target: latest release and previous minor train.
- Architecture coverage is best-effort across all declared targets.
- Releases are maintainer-owned and published manually as needed.

## Coding Standards

- Follow existing style in shell, YAML, and Markdown files.
- Prefer defensive scripting and explicit error handling.
- Use `bashio` helpers for Home Assistant configuration and logging.
- Keep comments short and focused on operational intent.

## Verification Before PR

- YAML parses successfully.
- Shell scripts pass syntax check and ShellCheck.
- Runtime contract checks pass.
- Documentation reflects behavior changes.
- CI workflows remain green.
- For behavior touching auth, ports, or ingress, note whether you validated on a real Home Assistant instance (see `OPERATIONS.md`).

## Commit Messages

Use conventional commit types when possible:

- `feat`: new behavior
- `fix`: bug fix
- `docs`: documentation changes
- `refactor`: internal code cleanup
- `test`: tests or validation updates
- `chore`: maintenance

## Pull Request Checklist

- [ ] Problem and solution are clearly described
- [ ] Behavior changes are tested or manually verified
- [ ] Documentation is updated where needed
- [ ] No unrelated changes are included

## Versioning

The project follows Semantic Versioning. Update `CHANGELOG.md` for user-visible changes.

## License

By contributing, you agree your changes are provided under the MIT License.
