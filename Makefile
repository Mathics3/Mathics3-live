.PHONY: all serve wheel
NOTEBOOK_VERSION=1.0.0

NOTEBOOK_WHEEL=pypi/Mathics3_notebook_frontends-$(NOTEBOOK_VERSION)-py3-none-any.whl
#: Build everything
all: $(NOTEBOOK_WHEEL)
	jupyter lite build --contents content --output-dir dist
	cp -f index.html dist/index.html

#: Make Build everything
$(NOTEBOOK_WHEEL):
	cd Mathics3-notebook-frontends && python3 -m build
	cp -f Mathics3-notebook-frontends/dist/[Mm]athics3_notebook_frontends-${NOTEBOOK_VERSION}-py3-none-any.whl $@

#: Start a HTTP webserver running Mathics3-live
serve: all
	cd dist && python3 -m http.server
