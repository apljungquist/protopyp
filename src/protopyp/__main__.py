import sys

import copier


def _main():
    copier.run_auto("gh:apljungquist/protopyp_template", sys.argv[1])
