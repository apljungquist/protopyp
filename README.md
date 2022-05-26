# Prototype Python Project

_A prototype for python projects_


## Goals
This project is generated from a [template](https://github.com/apljungquist/protopyp_template).
It is meant to
* test the template, and
* demonstrate what the result from the template can look like.


## How to run checks locally
Make sure the python versions listed in `.python-version` are installed.
If these are not available on your OS distribution consider installing [pyenv](https://github.com/pyenv/pyenv).

Now we can create our development environment, install dependencies and run all checks like

```bash
source ./init_env.sh
# Unlike CI this installs the current package as editable
pip install -r requirements.txt
make check_all
```
