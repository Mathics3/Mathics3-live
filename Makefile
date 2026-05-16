.PHONY: all clean-cache clean-serve serve runserver wheel

# NOTEBOOK_VERSION Mathics3-Live version. The wheel name has this number in it.
NOTEBOOK_VERSION ?= 1.0.0

PYTHON ?= python
HTTP_PORT ?= 8000

NOTEBOOK_WHEEL=pypi/Mathics3_notebook_frontends-$(NOTEBOOK_VERSION)-py3-none-any.whl
#: Build everything
all: $(NOTEBOOK_WHEEL)
	jupyter lite build --contents content --output-dir dist
	cp -f index.html dist/index.html

register-kernel:
	$(PYTHON3) ./install-kernel.py

#: Remove Jupyter Cache file
clean-cache:
	rm .jupyterlite.doit.db || true;


#: Make Build everything
$(NOTEBOOK_WHEEL):
	cd Mathics3-notebook-frontends && python3 -m build
	cp -f Mathics3-notebook-frontends/dist/[Mm]athics3_notebook_frontends-${NOTEBOOK_VERSION}-py3-none-any.whl $@

#: Start a HTTP webserver running Mathics3-live
runserver serve: all
	cd dist && python3 -m http.server $(HTTP_PORT)

#: Clean Jupyter cache and start a HTTP webserver running Mathics3-live
clean-serve: all clean-cache serve
