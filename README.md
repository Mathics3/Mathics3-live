# Mathics3 Live

![screenshot](./screenshot.png)

## Requirements

JupyterLite is being tested against modern web browsers:

- Firefox 90+
- Chromium 89+

## Installing and running locally

Install this code in a virtual Python environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

The above needs to be done only once.

Once the virtual environment has been set up with the packages installed, to run the server:

```bash
make serve
```

## Further Information and Updates

For more info, keep an eye on the JupyterLite documentation:

- Deployment: https://jupyterlite.readthedocs.io/en/latest/quickstart/deploy.html
- How-to Guides: https://jupyterlite.readthedocs.io/en/latest/howto/index.html
- Reference: https://jupyterlite.readthedocs.io/en/latest/reference/index.html
