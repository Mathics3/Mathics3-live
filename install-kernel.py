#!/bin/env python3
"""
A Command-line program to create a JSON kernel.json for Mathics3 JupyLite kernel.
"""
import argparse
import json
import os
import os.path as osp
import shutil
import sys
from tempfile import TemporaryDirectory

from jupyter_client.kernelspec import KernelSpecManager

KERNEL_NAME = "Mathics3-Live"
DISPLAY_NAME = "Mathics3 (using Jupyterlite)"
# The source directory for icons relative to the project root
ICON_SOURCE_DIR = osp.normpath(osp.join(osp.dirname(__file__), "img"))

kernel_json = {
    "argv": [
        sys.executable,
        "-m",
        "mathics3_kernel.frontend.jupyter",  # The module that handles the kernel loop
        "-f",
        "{connection_file}",
    ],
    "display_name": DISPLAY_NAME,
    "language": "wolfram",
    "metadata": {
        "language_info": {
            "name": "wolfram",
            "codemirror_mode": "gfm",
            "file_extension": ".wl",
            "mimetype": "text/x-wolfram",
        },
    },
}


def install_my_kernel_spec(user=True, prefix=None):
    """
    Creates a JSON 'kernel.json' file custom for the Mathics3 JupyterLite kernel of
    this project.
    """
    with TemporaryDirectory(prefix="kernel-", suffix=".json") as td:
        os.chmod(td, 0o755)  # Ensure Jupyter can read the directory

        # Write the kernel.json file
        with open(os.path.join(td, "kernel.json"), "w") as f:
            json.dump(kernel_json, f, sort_keys=True, indent=4)

        # Jupyter specifically looks for logo-32x32.png and logo-64x64.png
        icon_found = False
        if osp.isdir(ICON_SOURCE_DIR):
            for icon_name in ["logo-32x32.png", "logo-64x64.png"]:
                src_path = osp.normpath(osp.join(ICON_SOURCE_DIR, icon_name))
                if osp.exists(src_path):
                    print(f"Found icon: {icon_name}, adding to kernelspec...")
                    shutil.copy(src_path, td)
                    icon_found = True

        if not icon_found:
            print(
                f"Warning: No icons found in {ICON_SOURCE_DIR}/. Kernel will install without a logo."
            )

        print(f"Installing Jupyter kernel spec for {DISPLAY_NAME}...")
        try:
            KernelSpecManager().install_kernel_spec(
                td, KERNEL_NAME, user=user, prefix=prefix
            )
            print(
                "Successfully installed Mathics3 kernel in mathics3-jupyter/kernel.json"
            )
        except Exception as e:
            print(f"Failed to install kernel: {e}")


def _is_root():
    try:
        return os.getuid() == 0
    except AttributeError:
        return False  # Windows


def main(argv=None):
    parser = argparse.ArgumentParser(
        description=f"Install the {DISPLAY_NAME} kernel spec for Jupyter."
    )
    parser.add_argument(
        "--user",
        action="store_true",
        help="Install to the per-user kernelspec directory",
    )
    parser.add_argument(
        "--sys-prefix",
        action="store_true",
        help="Install to Python's sys.prefix (e.g. venv)",
    )
    parser.add_argument("--prefix", help="Install to the given prefix")

    args = parser.parse_args(argv)

    if args.sys_prefix:
        args.prefix = sys.prefix
    if not args.prefix and not args.user and _is_root():
        args.user = False

    install_my_kernel_spec(user=args.user or True, prefix=args.prefix)
    print("Installation complete.")


if __name__ == "__main__":
    main()
