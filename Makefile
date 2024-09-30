all: pypi/Mathics3-7.0.1.dev0-py3-none-any.whl

pypi/Mathics3-7.0.1.dev0-py3-none-any.whl:
	cd mathics-core && python3 -m build && cp -f dist/Mathics3-7.0.1.dev0-py3-none-any.whl ../pypi

serve: all
	jupyter lite serve --contents content
