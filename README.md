# Mathics3 Live

![screenshot](./screenshot.png)

## Requirements

JupyterLite is being tested against modern web browsers:

- Firefox 90+
- Chromium 89+

## Installing and running locally


###  Install Mathics3-notebook-frontends submodule

After cloning, Mathics3-notebook-frontends needs to be added as a git submodule. To do this:

```console
git submodule --init --recursive
```

If submodule change and you want to update what's here, you may need to run more `git submodule` commands.

Consult git docs for operating procudures when working with git submodules.


### Install in a virtual Python environment

To install this code in a virtual Python environment:
```console
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

The above also needs to be done only once.

Once the virtual environment has been set up with the packages installed, to run the server:

```console
make serve
```

## Making changes

If `index.html` is updated or possibly other changes, the JupyterLite cache, `.jupyterlite.doit.db` may need to be removed.

```console
make clean-serve
```

will both start the server after first reming

## Further Information and Updates

For more info, keep an eye on the JupyterLite documentation:

- Deployment: https://jupyterlite.readthedocs.io/en/latest/quickstart/deploy.html
- How-to Guides: https://jupyterlite.readthedocs.io/en/latest/howto/index.html
- Reference: https://jupyterlite.readthedocs.io/en/latest/reference/index.html
