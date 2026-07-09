#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');

const destDir = path.join(os.homedir(), '.claude', 'skills');
const kitDir = path.dirname(__dirname);

fs.mkdirSync(destDir, { recursive: true });

let installed = 0;

function installSkill(skillDir) {
  const skillMd = path.join(skillDir, 'SKILL.md');
  if (!fs.existsSync(skillMd)) return;
  const name = path.basename(skillDir);
  const dest = path.join(destDir, name);
  fs.mkdirSync(dest, { recursive: true });
  fs.copyFileSync(skillMd, path.join(dest, 'SKILL.md'));
  console.log(`  [+] /${name}`);
  installed++;
}

console.log('fable5-skill-kit');
console.log(`Installing to: ${destDir}\n`);

// Universal skills
const skillsDir = path.join(kitDir, 'skills');
if (fs.existsSync(skillsDir)) {
  for (const entry of fs.readdirSync(skillsDir, { withFileTypes: true })) {
    if (entry.isDirectory()) installSkill(path.join(skillsDir, entry.name));
  }
}

// Domain skills
const domainsDir = path.join(kitDir, 'domains');
if (fs.existsSync(domainsDir)) {
  for (const domain of fs.readdirSync(domainsDir, { withFileTypes: true })) {
    if (!domain.isDirectory()) continue;
    const domainSkills = path.join(domainsDir, domain.name, 'skills');
    if (!fs.existsSync(domainSkills)) continue;
    for (const entry of fs.readdirSync(domainSkills, { withFileTypes: true })) {
      if (entry.isDirectory()) installSkill(path.join(domainSkills, entry.name));
    }
  }
}

console.log(`\nDone. ${installed} skills installed.`);
console.log('\nRestart Claude Code, then use /fable to get started.');
