import shutil
import pathlib


def install_from(kit_dir):
    kit_dir = pathlib.Path(kit_dir)
    dest_dir = pathlib.Path.home() / ".claude" / "skills"
    dest_dir.mkdir(parents=True, exist_ok=True)

    print("fable5-skill-kit")
    print(f"Installing to: {dest_dir}\n")

    installed = 0

    def install_skill(skill_dir):
        nonlocal installed
        skill_md = skill_dir / "SKILL.md"
        if not skill_md.exists():
            return
        dest = dest_dir / skill_dir.name
        dest.mkdir(exist_ok=True)
        shutil.copy2(skill_md, dest / "SKILL.md")
        print(f"  [+] /{skill_dir.name}")
        installed += 1

    skills_dir = kit_dir / "skills"
    if skills_dir.exists():
        for entry in sorted(skills_dir.iterdir()):
            if entry.is_dir():
                install_skill(entry)

    domains_dir = kit_dir / "domains"
    if domains_dir.exists():
        for domain in sorted(domains_dir.iterdir()):
            if not domain.is_dir():
                continue
            domain_skills = domain / "skills"
            if not domain_skills.exists():
                continue
            for entry in sorted(domain_skills.iterdir()):
                if entry.is_dir():
                    install_skill(entry)

    print(f"\nDone. {installed} skills installed.")
    print("\nRestart Claude Code, then use /fable to get started.")


def main():
    # Skills ship as package data next to this file.
    root = pathlib.Path(__file__).parent
    install_from(root)


if __name__ == "__main__":
    main()
