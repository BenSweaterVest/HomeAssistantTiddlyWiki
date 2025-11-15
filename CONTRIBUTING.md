# Contributing to TiddlyWiki Home Assistant Add-on

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 🎯 Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Submit bug fixes
- ✨ Add new features
- 🧪 Add tests
- 🌍 Translate documentation

## 📋 Before You Start

1. **Search existing issues** to avoid duplicates
2. **Check the documentation** - your question might already be answered
3. **Use the latest version** - test against the current release

## 🐛 Reporting Bugs

### Before Submitting

- Check if the bug has already been reported
- Verify you're using the latest version
- Test with minimal configuration
- Check Home Assistant logs

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Environment:**
- Home Assistant version: [e.g., 2024.11]
- Add-on version: [e.g., 1.0.0]
- Architecture: [e.g., amd64]
- Configuration:
```yaml
port: 8080
# ... your config
```

**Logs:**
```
Paste relevant logs here
```

**Additional context**
Any other relevant information.
```

## 💡 Suggesting Features

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
What you want to happen.

**Describe alternatives you've considered**
Other solutions you've thought about.

**Additional context**
Any other relevant information, mockups, or examples.
```

## 🔧 Pull Requests

### Development Setup

```bash
# Clone the repository
git clone https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki.git
cd HomeAssistantTiddlyWiki

# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes

# Test your changes (see Testing section below)

# Commit your changes
git commit -m "Add: description of your changes"

# Push to your fork
git push origin feature/your-feature-name
```

### Commit Message Guidelines

Follow the conventional commits format:

```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

**Examples:**
```
feat: Add multi-user authentication support
fix: Resolve port configuration issue
docs: Update installation instructions
```

### Code Guidelines

#### Bash Scripts

- Use shellcheck for linting
- Follow existing code style
- Add comments for complex logic
- Use bashio functions for HA integration
- Handle errors appropriately
- Quote variables: `"${VARIABLE}"`

```bash
# Good
PORT=$(bashio::config 'port')
if [ -n "${PORT}" ]; then
    echo "Port: ${PORT}"
fi

# Bad
PORT=$(bashio::config 'port')
if [ -n $PORT ]; then
    echo "Port: $PORT"
fi
```

#### Dockerfile

- Use multi-stage builds when appropriate
- Minimize layers
- Clean up in the same RUN command
- Use specific base image versions
- Add clear comments

```dockerfile
# Good
RUN apk add --no-cache nodejs npm \
    && npm install -g tiddlywiki \
    && rm -rf /var/cache/apk/*

# Bad
RUN apk add nodejs npm
RUN npm install -g tiddlywiki
RUN rm -rf /var/cache/apk/*
```

#### YAML Files

- Use 2-space indentation
- Quote strings when needed
- Validate with: `python3 -c "import yaml; yaml.safe_load(open('file.yaml'))"`
- Follow Home Assistant add-on schema

### Testing

Before submitting a PR:

1. **Validate YAML files:**
   ```bash
   python3 -c "import yaml; yaml.safe_load(open('tiddlywiki/config.yaml'))"
   python3 -c "import yaml; yaml.safe_load(open('tiddlywiki/build.yaml'))"
   ```

2. **Check bash syntax:**
   ```bash
   bash -n tiddlywiki/run.sh
   ```

3. **Run shellcheck (if available):**
   ```bash
   shellcheck tiddlywiki/run.sh
   ```

4. **Test locally** (if possible):
   - Build the Docker image
   - Run in Home Assistant
   - Verify functionality

5. **Update documentation:**
   - Update README if needed
   - Update CHANGELOG.md
   - Add comments to code

### Pull Request Checklist

Before submitting your PR:

- [ ] Code follows project style guidelines
- [ ] All YAML files are valid
- [ ] Bash scripts pass syntax check
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated (for user-facing changes)
- [ ] Commit messages follow conventions
- [ ] PR description explains what and why
- [ ] No unnecessary files included

### PR Template

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Other (describe)

## Testing
How has this been tested?

## Checklist
- [ ] YAML files validated
- [ ] Bash syntax checked
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Tested locally

## Related Issues
Fixes #(issue number)
```

## 📝 Documentation

### Documentation Standards

- Use clear, concise language
- Include examples
- Keep formatting consistent
- Use proper markdown
- Add cross-references between docs

### Documentation Files

- `README.md` - Project overview and quick start
- `tiddlywiki/README.md` - Detailed add-on documentation
- `CHANGELOG.md` - Version history
- `TROUBLESHOOTING_403.md` - Common installation issues
- `DEPLOYMENT_GUIDE.md` - Maintainer deployment guide

## 🔍 Code Review Process

1. **Automated checks** - Must pass before review
2. **Maintainer review** - Code quality and design
3. **Testing** - Verify functionality
4. **Feedback** - Address review comments
5. **Approval** - Merge when ready

## 🏷️ Version Bumping

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR** (x.0.0): Breaking changes
- **MINOR** (0.x.0): New features (backward compatible)
- **PATCH** (0.0.x): Bug fixes

Update version in:
- `tiddlywiki/config.yaml`
- `CHANGELOG.md`

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🆘 Getting Help

- **Documentation:** Check existing docs first
- **Issues:** Search existing issues
- **Discussions:** Use GitHub Discussions for questions
- **Community:** Home Assistant Community Forum

## 🙏 Thank You!

Every contribution helps make this project better. Thank you for taking the time to contribute!

---

**Questions?** Open an issue or discussion on GitHub.
