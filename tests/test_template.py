import pathlib
import subprocess

TEMPLATE = pathlib.Path(__file__).parents[1] / "template"


def test_new_package_passes_tests(tmp_path):
    def check_call(cmd):
        subprocess.check_call(cmd, cwd=tmp_path)

    subprocess.check_call(["copier", "--defaults", str(TEMPLATE), str(tmp_path)])
    check_call(["git", "add", "."])
    check_call(["git", "commit", "-m", "Add boilerplate from template"])
    check_call(
        [
            "bash",
            "-c",
            (
                "set -e;"
                "source ./init_env.sh;"
                "pip install -r requirements.txt;"
                "make check_all"
            ),
        ],
    )
