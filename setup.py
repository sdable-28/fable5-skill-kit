import os
import shutil
from setuptools import setup
from setuptools.command.build_py import build_py


class BuildWithSkills(build_py):
    """Copy root skills/ and domains/ into the package so they ship as package data."""

    def run(self):
        here = os.path.dirname(os.path.abspath(__file__))
        pkg = os.path.join(here, "fable5_skill_kit")
        for folder in ("skills", "domains"):
            src = os.path.join(here, folder)
            dst = os.path.join(pkg, folder)
            if os.path.isdir(src):
                if os.path.isdir(dst):
                    shutil.rmtree(dst)
                shutil.copytree(src, dst)
        super().run()


setup(cmdclass={"build_py": BuildWithSkills})
