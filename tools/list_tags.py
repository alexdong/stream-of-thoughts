#!/usr/bin/env python3
"""
Utility to list category tags used in the Jekyll `_posts` directory.

By default it prints the unique tags in alphabetical order with their
occurrence counts. Use `--sort count` to order by descending frequency or
`--per-file` to show the tags attached to each post.
"""
from __future__ import annotations

import argparse
import sys
from collections import Counter
from pathlib import Path
from typing import Iterable, List


def parse_categories(path: Path) -> List[str]:
    """Extract the `categories` list from the file's front matter."""
    try:
        text = path.read_text(encoding="utf-8")
    except OSError as exc:  # pragma: no cover - best effort utility
        print(f"warning: unable to read {path}: {exc}", file=sys.stderr)
        return []

    if not text.startswith("---"):
        return []

    parts = text.split("---", 2)
    if len(parts) < 3:
        return []

    front_matter = parts[1]

    categories: List[str] = []

    # Try PyYAML if available for robust parsing.
    try:  # pragma: no cover - optional dependency
        import yaml  # type: ignore
    except ModuleNotFoundError:
        yaml = None  # type: ignore

    if yaml is not None:
        try:
            data = yaml.safe_load(front_matter)
        except Exception:
            data = None
        if isinstance(data, dict):
            cats = data.get("categories")
            if isinstance(cats, (list, tuple)):
                categories = [str(cat).strip() for cat in cats if str(cat).strip()]
            elif isinstance(cats, str):
                cat = cats.strip()
                if cat:
                    categories = [cat]

    if categories:
        return categories

    # Manual fallback: scan the YAML section for list-style entries.
    lines = front_matter.splitlines()
    for idx, line in enumerate(lines):
        if not line.strip().startswith("categories"):
            continue
        _, _, rest = line.partition(":")
        rest = rest.strip()
        extracted: List[str] = []
        if rest:
            if rest.startswith("[") and rest.endswith("]"):
                inner = rest[1:-1]
                extracted = [item.strip().strip("\"'") for item in inner.split(",")]
            else:
                extracted = [rest.strip().strip("\"'")]
        else:
            for sub in lines[idx + 1 :]:
                stripped = sub.strip()
                if not stripped:
                    break
                if stripped.startswith("- "):
                    extracted.append(stripped[2:].strip().strip("\"'"))
                elif stripped.startswith("#"):
                    break
                else:
                    # stop on the first non-list entry at the same indentation
                    leading_spaces = len(sub) - len(sub.lstrip())
                    if leading_spaces <= 1:
                        break
        categories = [item for item in extracted if item]
        break

    return categories


def iter_post_paths(posts_dir: Path) -> Iterable[Path]:
    if not posts_dir.is_dir():
        raise SystemExit(f"_posts directory not found at {posts_dir}")
    yield from sorted(posts_dir.glob("*.md"))


def main(argv: Iterable[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--sort",
        choices=("alpha", "count"),
        default="alpha",
        help="Ordering for the aggregated tag list",
    )
    parser.add_argument(
        "--per-file",
        action="store_true",
        help="Display the categories used by each individual post",
    )

    args = parser.parse_args(list(argv) if argv is not None else None)

    repo_root = Path(__file__).resolve().parents[1]
    posts_dir = repo_root / "_posts"

    counts: Counter[str] = Counter()
    per_file: list[tuple[Path, List[str]]] = []

    for path in iter_post_paths(posts_dir):
        cats = parse_categories(path)
        if cats:
            counts.update(cats)
        per_file.append((path.relative_to(repo_root), cats))

    if args.per_file:
        for rel_path, cats in per_file:
            joined = ", ".join(cats) if cats else "<none>"
            print(f"{rel_path}: {joined}")
        if counts:
            print()

    if not counts:
        print("No categories found.")
        return 0

    if args.sort == "count":
        items = sorted(counts.items(), key=lambda item: (-item[1], item[0]))
    else:
        items = sorted(counts.items(), key=lambda item: item[0])

    width = max(len(name) for name, _ in items)
    for name, count in items:
        print(f"{name.ljust(width)}  {count}")

    return 0


if __name__ == "__main__":  # pragma: no cover
    raise SystemExit(main())
