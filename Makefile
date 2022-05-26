### Config ###
# Delete targets that fail (to prevent subsequent attempts to make incorrectly
# assuming the target is up to date). Especially useful with the envoy pattern.
.DELETE_ON_ERROR: ;

SHELL=/bin/bash


### Macros and variables ###

CLEAN_DIR_TARGET = git clean -xdf $(@D); mkdir -p $(@D)


### Verbs ###
# * are targets
# * can have side effect, but side effects should not affect nouns
# * should not be prerequisites of other targets

check_all: check_format check_types check_lint check_tests

check_format:
	black --check tests/

check_lint:
	pylint tests/
	flake8 tests/

check_tests:
	pytest --durations=10 tests/

check_types:
	mypy tests/

fix_format:
	black tests/

# For some reason pip-sync does not install all packages needed for black
sync_env:
	pip install -r requirements.txt


### Nouns ###
# * Should have no side effects
# * Must have no side effects on other nouns
# * Ordered first by specificity, second by name

constraints.txt: requirements.txt
	pip-compile --allow-unsafe --strip-extras --output-file $@ $^

reports/test_coverage/.coverage: $(wildcard .coverage.*)
	coverage combine --keep --data-file=$@ $^

reports/test_coverage/html/index.html: reports/test_coverage/.coverage
	coverage html --data-file=$< --directory=$(@D)
