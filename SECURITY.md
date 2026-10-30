# Security Policy

## Supported versions

Only the latest release receives fixes.

| Version | Supported |
|---------|-----------|
| 1.0.x (latest) | Yes |
| Older | No |

## Reporting a vulnerability

Please **do not open a public issue** for security problems.

Report privately through GitHub: go to the repository's **Security** tab → **Report a vulnerability**. This opens a private advisory visible only to the maintainer.

Include what you can:

- the file(s) affected (a skill path, an installer, or the npm package)
- what an attacker could do, and the steps to reproduce it
- the version or commit you tested

You can expect an acknowledgement within 7 days. Confirmed issues are fixed in a new release, and the advisory is published once a fix is out. Credit is given unless you ask otherwise.

## What is in scope

This kit is plain Markdown instructions plus three small installers. The things worth reporting:

- **Instructions that cause harm.** Any skill text that tells the model to run destructive commands, exfiltrate data, read or reveal secrets, disable safety checks, or follow instructions embedded in untrusted content.
- **Installer behavior.** `bin/install.js` (`npx fable5-skill-kit`), `install.sh` and `install.ps1` should do one thing: copy `SKILL.md` files into `~/.claude/skills/`. Anything else — network access, writing outside that folder, executing code, deleting files — is a bug.
- **Package integrity.** The npm package `fable5-skill-kit` should contain only `bin/`, `skills/` and `domains/` matching this repository. A mismatch between the published package and the tagged source is a security issue.

Out of scope: the behavior of Claude or other models themselves, and how a skill performs on a task (open a normal issue for quality problems).

## Notes for users

- **Read before you install.** Skills change how an AI agent behaves in your environment. Every skill is a short Markdown file — review them, especially if you install from a fork or a copy.
- **The installers overwrite same-named skills.** If `~/.claude/skills/<name>/SKILL.md` already exists, it is replaced. Back up any custom skills that share a name with one in this kit.
- **Install from the official sources only:** this repository, or the npm package `fable5-skill-kit`.
