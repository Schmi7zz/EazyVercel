# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.0   | ✅        |
| 1.0.2   | ✅        |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please **do not** open a public issue.

Instead, please report it privately:

1. Send a message to [@Schmi7zz](https://t.me/Schmi7zz) on Telegram
2. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Security Best Practices

- **Never share your tokens**: Vercel/Netlify tokens should be kept private
- **Use strong passwords**: For your server and CDN accounts
- **Keep dependencies updated**: Run updates regularly
- **Monitor logs**: Check `/tmp/EazyVercel.log` for any suspicious activity
- **Use HTTPS only**: This installer automatically configures SSL/TLS

## Known Security Considerations

- The installer runs as **root** on Ubuntu servers — ensure you trust the source
- The relay endpoint (Vercel/Netlify) is publicly accessible — protect it with proper DNS and access controls
- SSL certificates are obtained via Let's Encrypt — ensure ports 80/443 are accessible during installation

## Disclosure Policy

We aim to:

1. Acknowledge receipt of vulnerability reports within 48 hours
2. Provide a detailed response within 7 days
3. Release a fix as soon as reasonably possible

## License and Attribution

This project is licensed under GPL-3.0. Unauthorized modification or redistribution without proper attribution is a copyright violation and will be subject to DMCA takedown.

---

**Copyright © 2026 [@Schmi7zz](https://t.me/Schmi7zz)**
