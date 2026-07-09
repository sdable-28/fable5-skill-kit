#!/usr/bin/env bash
# fable-kit install script — Mac / Linux
# Copies all skills to ~/.claude/skills/ for use with Claude Code
# Usage: bash install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SOURCE="$SCRIPT_DIR/skills"
DOMAINS_SOURCE="$SCRIPT_DIR/domains"
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

echo "fable-kit installer"
echo "Installing to: $CLAUDE_SKILLS_DIR"
echo ""

mkdir -p "$CLAUDE_SKILLS_DIR"

installed=0

# Install universal skills from skills/
if [ -d "$SKILLS_SOURCE" ]; then
    for skill_dir in "$SKILLS_SOURCE"/*/; do
        skill_md="$skill_dir/SKILL.md"
        if [ -f "$skill_md" ]; then
            skill_name="$(basename "$skill_dir")"
            dest_dir="$CLAUDE_SKILLS_DIR/$skill_name"
            mkdir -p "$dest_dir"
            cp "$skill_md" "$dest_dir/SKILL.md"
            echo "  [+] /$skill_name"
            installed=$((installed + 1))
        fi
    done
fi

# Install domain skills from domains/*/skills/
if [ -d "$DOMAINS_SOURCE" ]; then
    for domain_dir in "$DOMAINS_SOURCE"/*/; do
        domain_skills_dir="$domain_dir/skills"
        if [ -d "$domain_skills_dir" ]; then
            for skill_dir in "$domain_skills_dir"/*/; do
                skill_md="$skill_dir/SKILL.md"
                if [ -f "$skill_md" ]; then
                    skill_name="$(basename "$skill_dir")"
                    dest_dir="$CLAUDE_SKILLS_DIR/$skill_name"
                    mkdir -p "$dest_dir"
                    cp "$skill_md" "$dest_dir/SKILL.md"
                    echo "  [+] /$skill_name"
                    installed=$((installed + 1))
                fi
            done
        fi
    done
fi

echo ""
echo "Done. $installed skills installed."
echo ""
echo "Restart Claude Code, then use any skill with /skill-name in conversation."
echo "Start with /fable to auto-detect your domain and activate the right discipline."
