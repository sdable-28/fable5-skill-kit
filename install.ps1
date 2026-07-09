# fable-kit install script — Windows PowerShell
# Copies all skills to ~/.claude/skills/ for use with Claude Code
# Usage: .\install.ps1

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillsSource = Join-Path $scriptDir "skills"
$domainsSource = Join-Path $scriptDir "domains"
$claudeSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"

Write-Host "fable-kit installer" -ForegroundColor Cyan
Write-Host "Installing to: $claudeSkillsDir"
Write-Host ""

# Create destination if it doesn't exist
if (-not (Test-Path $claudeSkillsDir)) {
    New-Item -ItemType Directory -Force -Path $claudeSkillsDir | Out-Null
    Write-Host "Created: $claudeSkillsDir"
}

$installed = 0
$skipped = 0

# Install universal skills from skills/
if (Test-Path $skillsSource) {
    $skillDirs = Get-ChildItem -Path $skillsSource -Directory
    foreach ($skillDir in $skillDirs) {
        $skillMd = Join-Path $skillDir.FullName "SKILL.md"
        if (Test-Path $skillMd) {
            $destDir = Join-Path $claudeSkillsDir $skillDir.Name
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Force -Path $destDir | Out-Null
            }
            $destFile = Join-Path $destDir "SKILL.md"
            Copy-Item -Path $skillMd -Destination $destFile -Force
            Write-Host "  [+] /$($skillDir.Name)" -ForegroundColor Green
            $installed++
        }
    }
}

# Install domain skills from domains/*/skills/
if (Test-Path $domainsSource) {
    $domainDirs = Get-ChildItem -Path $domainsSource -Directory
    foreach ($domainDir in $domainDirs) {
        $domainSkillsDir = Join-Path $domainDir.FullName "skills"
        if (Test-Path $domainSkillsDir) {
            $skillDirs = Get-ChildItem -Path $domainSkillsDir -Directory
            foreach ($skillDir in $skillDirs) {
                $skillMd = Join-Path $skillDir.FullName "SKILL.md"
                if (Test-Path $skillMd) {
                    $destDir = Join-Path $claudeSkillsDir $skillDir.Name
                    if (-not (Test-Path $destDir)) {
                        New-Item -ItemType Directory -Force -Path $destDir | Out-Null
                    }
                    $destFile = Join-Path $destDir "SKILL.md"
                    Copy-Item -Path $skillMd -Destination $destFile -Force
                    Write-Host "  [+] /$($skillDir.Name)" -ForegroundColor Green
                    $installed++
                }
            }
        }
    }
}

Write-Host ""
Write-Host "Done. $installed skills installed." -ForegroundColor Cyan
Write-Host ""
Write-Host "Restart Claude Code, then use any skill with /skill-name in conversation."
Write-Host "Start with /fable to auto-detect your domain and activate the right discipline."
