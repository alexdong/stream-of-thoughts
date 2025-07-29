# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based static site for alexdong.com, a personal blog. The site uses the Minima theme and is deployed to GitHub Pages via the `docs/` directory.

## Architecture

- **Jekyll Site**: Standard Jekyll blog structure with `_config.yml`, `_posts/`, and standard Jekyll directories
- **Theme**: Uses the Minima theme (`minima ~> 2.5`)
- **Deployment**: Built to `docs/` directory for GitHub Pages hosting
- **Domain**: Custom domain `alexdong.com` configured via CNAME

## Key Commands

### Create New Post
```bash
make new
```
Interactive command that prompts for a post title, creates a new post file in `_posts/` with proper naming convention and Jekyll front matter template, then opens it in your `$EDITOR`.

### Build and Deploy
```bash
make publish
```
Complete deployment workflow that builds the site, creates CNAME file, commits changes, and pushes to git.

### Development
```bash
make dev
```
Starts Jekyll development server with live reload at http://localhost:4000.

### Other Commands
```bash
make help      # Show all available commands
make clean     # Clean generated files
make install   # Install Jekyll dependencies
```

### Legacy Commands
```bash
./publish                    # Original deployment script (use make publish instead)
bundle exec jekyll serve     # Manual dev server (use make dev instead)
bundle exec jekyll build -d docs  # Manual build (use make publish instead)
```

## File Structure

- `_config.yml`: Jekyll configuration with site metadata and build settings
- `_posts/`: Blog posts in Markdown format with YYYY-MM-DD-title.md naming
- `docs/`: Generated site output directory (GitHub Pages source)
- `Gemfile`: Ruby dependencies including Jekyll and plugins
- `publish`: Deployment script that builds, commits, and pushes

## Content Management

Blog posts are stored in `_posts/` and follow Jekyll's naming convention. The site uses Jekyll Feed plugin for RSS generation.

## Development Notes

- Site builds to `docs/` directory which serves as the GitHub Pages source
- Custom domain is maintained via CNAME file in the root of `docs/`
- The `publish` script automates the entire deployment workflow