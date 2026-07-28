# Install as local package
import shutil
import sys
import pathlib
import os
import toml

root = pathlib.Path(__file__).parent.resolve()

copy_dest_dir = ""

if sys.platform.startswith("linux"):
    copy_dest_dir = str(pathlib.Path.home()) + "/.local/share/typst/packages/local/"
elif sys.platform.startswith("win32"):
    copy_dest_dir = os.getenv("APPDATA") + "/typst/packages/local/"
elif sys.platform.startswith("darwin"):
    copy_dest_dir = str(pathlib.Path.home()) + "/Library/Application Support/typst/packages/local/"
else:
    print('Error: Unsupported platform')
    exit(0)

package = toml.load(root / "typst.toml")

copy_dest_dir = pathlib.Path(copy_dest_dir) / package["package"]["name"] / package["package"]["version"]

if __name__ == "__main__":
    copy_dest_dir.mkdir(parents=True,exist_ok=True)
    shutil.copytree(root / "assets", copy_dest_dir / "assets", ignore=shutil.ignore_patterns(".gitignore"))
    shutil.copytree(root / "lib", copy_dest_dir / "lib", ignore=shutil.ignore_patterns(".gitignore"))
    shutil.copy2(root / "LICENSE", copy_dest_dir)
    shutil.copy2(root / "typst.toml", copy_dest_dir)

