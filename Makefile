### Config ###
# Delete targets that fail (to prevent subsequent attempts to make incorrectly
# assuming the target is up to date). Especially useful with the envoy pattern.
.DELETE_ON_ERROR: ;

SHELL=/bin/bash


### Macros and variables ###

CLEAN_DIR_TARGET = git clean -xdf $(@D); mkdir -p $(@D)


### Verbs ###
# * May have side effect
# * Should not have side effects should not affect nouns

check_all: check_format check_types check_lint check_tests check_dist

check_format:
	isort --check setup.py src/ tests/
	black --check setup.py src/ tests/

check_lint:
	pylint setup.py src/ tests/
	flake8 setup.py src/ tests/

check_dist: dist/_envoy;

check_tests:
	tox -e py

check_types:
	mypy \
		--cobertura-xml-report=reports/type_coverage/ \
		--html-report=reports/type_coverage/html/ \
		--package protopyp

fix_format:
	isort setup.py src/ tests/
	black setup.py src/ tests/

### Nouns ###
# * Should have no side effects
# * Must have no side effects on other nouns
# * Must not have any prerequisites that are verbs
# * Ordered first by specificity, second by name

constraints.txt: requirements/tox.txt $(wildcard requirements/*.txt)
	pip-compile --allow-unsafe --strip-extras --output-file $@ $^ > /dev/null

dist/_envoy:
	$(CLEAN_DIR_TARGET)
	python -m build --outdir $(@D) .
	twine check $(@D)/*

reports/test_coverage/.coverage: $(wildcard .coverage.*)
	coverage combine --keep --data-file=$@ $^

reports/test_coverage/html/index.html: reports/test_coverage/.coverage
	coverage html --data-file=$< --directory=$(@D)

reports/test_coverage/coverage.xml: reports/test_coverage/.coverage
	coverage xml --data-file=$< -o $@

requirements/tox.txt: tox.ini
	tox -l --requirements-file $@
	touch $@
