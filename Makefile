all: pypi/Mathics3-7.0.1.dev0-py3-none-any.whl

pypi/Mathics3-7.0.1.dev0-py3-none-any.whl:
	cd mathics-scanner && pip install -e .
	cd mathics-core && admin-tools/make-op-tables.sh && python3 setup.py bdist_wheel
	cp -f mathics-core/dist/Mathics3-7.0.1.dev0-py3-none-any.whl $@

serve: all
	jupyter lite serve --contents content
