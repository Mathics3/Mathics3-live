.PHONY: all serve

#: Build everything
all: pypi/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl
	jupyter lite build --contents content --output-dir dist
	cp -f index.html dist/index.html

pypi/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl:
	cd Mathics3-notebook-frontends && python3 -m build
	cp -f Mathics3-notebook-frontends/dist/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl $@

#: Start a HTTP webserver running Mathics3-live
serve: all
	cd dist && python3 -m http.server
