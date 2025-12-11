# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

### Email

Send an email to: **benjiman.blanchard@gmail.com**

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if you have one)

### What to Expect

- **Initial Response:** Within 48 hours
- **Status Update:** Within 7 days
- **Fix Timeline:** Depends on severity
  - Critical: 1-3 days
  - High: 1-2 weeks
  - Medium: 2-4 weeks
  - Low: Next release cycle

## Security Best Practices for Users

### 1. Authentication

**Enable authentication for public-facing installations:**

```yaml
username: "admin"
password: "strong-secure-password-here"
```

**Never use default or weak passwords!**

### 2. Network Security

- Run on trusted networks only (or use auth)
- Don't expose directly to the internet
- Use Home Assistant's SSL/TLS if accessing remotely
- Consider using a VPN for remote access

### 3. Updates

- Keep the add-on updated to the latest version
- Monitor GitHub releases for security updates
- Check CHANGELOG.md for security-related fixes

### 4. Configuration

- Use strong passwords (minimum 12 characters)
- Review logs regularly for suspicious activity
- Limit access via firewall rules when possible

### 5. Data Protection

- Regular backups via Home Assistant
- Protect your TiddlyWiki data
- Be cautious with sensitive information in tiddlers

## Known Security Considerations

### Open Access Mode (No Authentication)

**Risk:** When username/password are not configured, anyone on your network can:
- Read all wiki content
- Edit all wiki content
- Delete tiddlers
- Modify wiki configuration

**Mitigation:**
- Only use on trusted home networks
- Enable authentication if needed
- Use network segmentation
- Monitor access logs

### Port Exposure

**Risk:** Port 8080 (or configured port) is exposed on your network

**Mitigation:**
- Use firewall rules to limit access
- Enable Home Assistant's SSL proxy
- Don't port-forward to the internet without authentication

### Container Privileges

**Risk:** Add-on runs with specific Home Assistant permissions

**Mitigation:**
- We use minimal required permissions
- No privileged mode required
- Limited to share and backup directories

## Security Features

### Built-in Security

✅ **Optional Authentication** - HTTP Basic Auth support
✅ **Input Validation** - Configuration schema validation
✅ **No Hardcoded Secrets** - All credentials via configuration
✅ **Minimal Base Image** - Alpine Linux for reduced attack surface
✅ **Read-only Root** - Except /data directory
✅ **No Unnecessary Services** - Only TiddlyWiki runs

### What We Don't Do

❌ Store passwords in plain text (handled by HA)
❌ Run as privileged container
❌ Expose unnecessary ports
❌ Include unnecessary packages
❌ Auto-upgrade without user consent

## Disclosure Policy

### Our Commitments

- Acknowledge receipt within 48 hours
- Provide regular updates on fix progress
- Credit security researchers (if desired)
- Publish security advisories for confirmed issues
- Release patches promptly

### Coordinated Disclosure

We follow coordinated disclosure:
1. Researcher reports vulnerability privately
2. We confirm and develop fix
3. We release patched version
4. We publish security advisory
5. Researcher gets credit (optional)

**Embargo Period:** 90 days maximum

## Security Advisories

Security advisories will be published at:
- GitHub Security Advisories
- CHANGELOG.md (tagged as SECURITY)
- GitHub Releases notes

## Scope

### In Scope

- Authentication bypass
- Code injection vulnerabilities
- Data exposure issues
- Privilege escalation
- Denial of service (if severe)

### Out of Scope

- Social engineering
- Physical attacks
- DDoS from external networks
- Issues in Home Assistant core
- Issues in TiddlyWiki itself
- Theoretical attacks requiring MITM on local network

## Contact

- **Security Email:** benjiman.blanchard@gmail.com
- **Project Issues:** https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues
- **GitHub Security:** https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/security

## Thank You

We appreciate the security research community's efforts to help keep this project safe!

---

**Last Updated:** 2024-11-14
