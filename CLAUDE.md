# Project Overview

This is a Jekyll-based personal website (alexdong.com) that implements "The Monospace Web" aesthetic. The repository contains custom CSS styling for a monospace-themed design.

## Architecture

### Tech Stack
- **Static Site Generator**: Jekyll with Minima theme
- **Styling**: SCSS with custom monospace CSS overrides
- **CSS Framework**: Custom implementation based on The Monospace Web design principles

### Key Files
- `assets/css/monospace.css`: Core monospace styling implementation
- `assets/main.scss`: Main SCSS file that imports Minima theme and applies monospace overrides

## Development Workflow

### Makefile Targets
The repository ships with a Makefile that wraps the most common Jekyll tasks. Prefer these commands so the expected flags and post-processing steps run consistently:

- `make install` – Install Ruby gems via Bundler.
- `make dev` – Start the incremental Jekyll server with LiveReload enabled (`bundle exec jekyll serve --livereload --incremental`).
- `make new` – Scaffold a new post in `_posts/` using the current date, prompt for a title, and open it in the `$EDITOR` (defaults to `vim`).
- `make build` – Build the site into `docs/` and refresh the `CNAME` file without touching git state.
- `make publish` – Build the site into `docs/`, write the `CNAME`, stage all changes, commit with the message "new post", and push to the current branch.
- `make clean` – Run `jekyll clean` and wipe the generated `docs/` artifacts.
- `make help` – List available targets and descriptions.

When publishing, remember the automated commit message is fixed. If you need a different message or additional git steps, run them manually after `make publish` or perform the build/push yourself. For quick experiments without committing, prefer `make build` followed by any manual git workflow you need.

## Design System

The site uses a monospace-first design with:
- Max content width: 80 characters
- Character-based spacing units
- Dark mode support via CSS media queries
- Consistent monospace styling across all elements

## CSS Architecture

The styling follows a two-layer approach:
1. `monospace.css`: Base monospace styling with CSS custom properties
2. `main.scss`: Jekyll/Minima integration and overrides

Key CSS variables defined:
- `--char-width`: 0.6em (base unit for spacing)
- `--spacing-unit`: 2 character widths
- Color scheme variables for light/dark modes

## Common Tasks

### Adding new pages
- Create `.md` or `.html` files in the root directory
- Add front matter with layout specification
- Pages will automatically use the monospace styling

### Modifying styles
- For global monospace styles: Edit `assets/css/monospace.css`
- For Jekyll-specific overrides: Edit `assets/main.scss`
- Maintain consistency with the monospace aesthetic

### Working with the grid system
- Use the `.grid` class for character-width based layouts
- Grid items automatically size to minimum 20 characters wide