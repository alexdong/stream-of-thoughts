# Repository Guidelines

## Project Structure & Module Organization
- `_posts/` holds dated Markdown posts (`YYYY-MM-DD-title.md`); front matter sets layout, categories, metadata.
- `_layouts/`, `_includes/`, `_sass/` define Liquid templates and styles; stash snippets under `_includes/partials/`.
- `assets/` houses media and compiled CSS; group by type (`assets/images/`, `assets/js/`).
- `docs/` is the published output; regenerate via build and leave unedited.
- `_config.yml`, `Gemfile`, `Makefile` anchor config, gem versions, and task automation.

## Build, Test, and Development Commands
- `bundle install` refreshes Ruby gems after touching the Gemfile or plugins.
- `make dev` (alias for `bundle exec jekyll serve --livereload --incremental`) previews on `http://localhost:4000`.
- `make build` or `bundle exec jekyll build -d docs` produces release HTML and rewrites `docs/CNAME`.
- `make new` scaffolds a post with today’s date then opens it in `$EDITOR`.
- `make clean` runs `jekyll clean` and purges `docs/` artifacts before retrying a broken build.

## Coding Style & Naming Conventions
- Use 2-space indentation for YAML and Liquid; wrap Markdown near 100 columns.
- Prefer kebab-case filenames and Liquid IDs; keep `_sass/**/*.scss` nesting shallow.
- Push conditional logic into `_plugins/` Ruby helpers instead of template branches.
- Optimize images before committing and link with relative paths (`![alt](../assets/images/example.jpg)`).

## Voice & Tone Guidelines
- Lead posts with a concise TLDR or framing line, then unfold insight in short, direct paragraphs.
- Write in first-person, pairing pragmatic walkthroughs with reflective takeaways; keep the vibe curious and optimistic.
- Cite primary sources with inline links and block quotes; contrast data points via tables or bullet lists when it clarifies the argument.
- Use rhetorical questions sparingly, and favor plain language with an active, declarative voice.

## Testing & Verification
- Run `bundle exec jekyll build` before committing; fix missing includes, assets, or front matter keys immediately.
- Browse changes locally via `make dev`, click new entries, and spot-check syntax highlighting and responsiveness.
- After a build, review the `docs/` diff to confirm only intended HTML ships and the `CNAME` file remains.

## Commit & Pull Request Guidelines
- Mirror the existing history (`new post`, `update styles`): imperative, lowercase, ≤50 characters when practical.
- Keep content, front matter, and assets together per commit for clean review trails.
- PRs should describe scope, note manual verification (`make dev`, screenshots), and link any tracking issues.
- Exclude local cache or preview files; record new gems in `Gemfile` and refresh `Gemfile.lock`.
