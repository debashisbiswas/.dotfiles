#!/usr/bin/env python

from datetime import datetime
import os
import sys
from pathlib import Path
import textwrap

root_env_var = "OBSIDIAN_VAULT_ROOT"


def category_template(name: str):
    return textwrap.dedent(f"""\
        ---
        created: {datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}
        ---
        ![[{name}.base]]
    """)


def base_template(name: str):
    return textwrap.dedent(f"""\
        filters:
          or:
            - category.containsAny(link("{name}"))
        views:
          - type: table
            name: Table
    """)


def main():
    if not (vault_root := os.getenv(root_env_var)):
        print(f"need to specify {root_env_var}", file=sys.stderr)
        sys.exit(1)

    if len(sys.argv) > 1:
        category_name = sys.argv[1].capitalize()
    else:
        print("missing arg: category name", file=sys.stderr)
        sys.exit(1)

    print(f"using category name: {category_name}")

    vault_root = Path(vault_root)

    if not vault_root.exists():
        print(f"{vault_root} does not exist", file=sys.stderr)
        sys.exit(1)

    if not vault_root.is_dir():
        print(f"{vault_root} is not a directory", file=sys.stderr)
        sys.exit(1)

    if not vault_root.joinpath(".obsidian").exists():
        print(
            f"warn: {vault_root} does not contain .obsidian, is it the right path?",
            file=sys.stderr,
        )

    category_file = Path(vault_root.joinpath(f"categories/{category_name}.md"))
    print(f"creating {category_file}")
    _ = category_file.write_text(category_template(category_name))

    base_file = Path(vault_root.joinpath(f"bases/{category_name}.base"))
    print(f"creating {base_file}")
    _ = base_file.write_text(base_template(category_name))


if __name__ == "__main__":
    main()
