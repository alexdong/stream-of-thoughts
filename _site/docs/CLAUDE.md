# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal website (alexdong.com) that implements "The Monospace Web" aesthetic. The repository contains custom CSS styling for a monospace-themed design.

## Architecture

### Tech Stack
- **Static Site Generator**: Jekyll with Minima theme
- **Styling**: SCSS with custom monospace CSS overrides
- **CSS Framework**: Custom implementation based on The Monospace Web design principles

### Key Files
- `assets/css/monospace.css`: Core monospace styling implementation
- `assets/main.scss`: Main SCSS file that imports Minima theme and applies monospace overrides

## Development Commands

Since this is a Jekyll site, use the following commands:

```bash
# Install dependencies (if Gemfile exists in parent directory)
bundle install

# Serve the site locally with auto-reload
bundle exec jekyll serve

# Build the site for production
bundle exec jekyll build

# Build with production environment
JEKYLL_ENV=production bundle exec jekyll build
```

## Design System

The site uses a monospace-first design with:
- Font: 'Courier New', Courier, monospace
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