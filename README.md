# protopyp

_A prototype for python project_

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
