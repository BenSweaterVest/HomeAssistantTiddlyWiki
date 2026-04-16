import re
from pathlib import Path
import sys


RUN_SH = Path("tiddlywiki/run.sh").read_text(encoding="utf-8")
CONFIG_YAML = Path("tiddlywiki/config.yaml").read_text(encoding="utf-8")


def require(snippet: str, content: str, message: str) -> None:
    if snippet not in content:
        print(f"FAIL: {message}")
        sys.exit(1)


def require_regex(pattern: str, content: str, message: str) -> None:
    if re.search(pattern, content, flags=re.MULTILINE) is None:
        print(f"FAIL: {message}")
        sys.exit(1)


require_regex(r"^\s*set -[a-zA-Z]*e[a-zA-Z]*u[a-zA-Z]*\s*$", RUN_SH, "run.sh must enable nounset and errexit")
require("pipefail", RUN_SH, "run.sh must enable pipefail when available")
require("password=***REDACTED***", RUN_SH, "run.sh must redact password values in logs")
require_regex(r'exec\s+"\$\{TIDDLYWIKI_CMD\[@\]\}"', RUN_SH, "run.sh must exec TiddlyWiki via argv array")
require_regex(r"command -v tiddlywiki", RUN_SH, "run.sh must verify tiddlywiki exists before use")
require("ingress: true", CONFIG_YAML, "config.yaml must enable Home Assistant ingress")
require("ingress_port: 8080", CONFIG_YAML, "config.yaml must route ingress to container port 8080")
require('webui: "http://[HOST]:[PORT:8080]"', CONFIG_YAML, "config.yaml must declare Web UI on container port 8080")
require('watchdog: "tcp://[HOST]:[PORT:8080]"', CONFIG_YAML, "config.yaml must declare watchdog on container port 8080")
require('auth_mode: "none"', CONFIG_YAML, "config.yaml must define default auth_mode")
require('auth_mode: "list(none|edit|all)?"', CONFIG_YAML, "config.yaml must define auth_mode schema")

if "hassio_api:" in CONFIG_YAML:
    print("FAIL: config.yaml should not request Home Assistant API access unless it is used")
    sys.exit(1)

print("Runtime contract checks passed.")
