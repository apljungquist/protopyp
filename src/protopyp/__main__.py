import sys

import copier


def main() -> None:
    copier.run_auto("gh:apljungquist/protopyp_template", sys.argv[1])
