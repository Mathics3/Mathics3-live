all: pypi/Mathics3-7.0.1.dev0-py3-none-any.whl pypi/pymathics_graph-7.0.1.dev0-py3-none-any.whl pypi/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl
	jupyter lite build --contents content --output-dir dist
	cp -f index.html dist/index.html

pypi/Mathics3-7.0.1.dev0-py3-none-any.whl:
	cd pypi && wget https://github.com/Mathics3/mathics-omnibus/releases/download/8.0.0.rc1/Mathics3-7.0.1.dev0-py3-none-any.whl

pypi/pymathics_graph-7.0.1.dev0-py3-none-any.whl:
	cd pypi && wget https://github.com/Mathics3/mathics-omnibus/releases/download/8.0.0.rc1/pymathics_graph-7.0.1.dev0-py3-none-any.whl

pypi/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl:
	cd Mathics3-notebook-frontends && python3 -m build
	cp -f Mathics3-notebook-frontends/dist/Mathics3_notebook_frontends-0.1.0-py3-none-any.whl $@

serve: all
	cd dist && python3 -m http.server
