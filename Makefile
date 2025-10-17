.PHONY: new publish dev clean help build deps

# Default editor (can be overridden by environment variable)
EDITOR ?= vim

# Ensure Homebrew Ruby is in PATH
export PATH := /opt/homebrew/opt/ruby/bin:$(PATH)

# Prefer Homebrew bundler when available to match Gemfile.lock version
BUNDLE ?= bundle
ifneq ("$(wildcard /opt/homebrew/opt/ruby/bin/bundle)","")
	BUNDLE := /opt/homebrew/opt/ruby/bin/bundle
endif

# Get current date in YYYY-MM-DD format
DATE := $(shell date +%Y-%m-%d)
TIME := $(shell date +%H:%M)

help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

new: ## Create a new blog post with template
	@echo "Creating new blog post..."
	@read -p "Enter post title: " title; \
	filename="_posts/$(DATE)-$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-zA-Z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$$//g').md"; \
	if [ -f "$$filename" ]; then \
		echo "File $$filename already exists!"; \
		exit 1; \
	fi; \
	echo "---" > "$$filename"; \
	echo "layout: post" >> "$$filename"; \
	echo "title: \"$$title\"" >> "$$filename"; \
	echo "date: $(DATE) $(TIME)" >> "$$filename"; \
	echo "comments: true" >> "$$filename"; \
	echo "categories: " >> "$$filename"; \
	echo "---" >> "$$filename"; \
	echo "" >> "$$filename"; \
	echo "Write your post content here..." >> "$$filename"; \
	echo "" >> "$$filename"; \
	echo "Created $$filename"; \
	$(EDITOR) "$$filename"

deps: ## Ensure Ruby dependencies are installed
	@echo "Checking Ruby dependencies..."
	@$(BUNDLE) check >/dev/null 2>&1 || (echo "Installing missing gems..." && $(BUNDLE) install)

publish: deps ## Build and deploy the site
	@echo "Building and deploying site..."
	@SASS_SILENCE_DEPRECATIONS=* $(BUNDLE) exec jekyll build -d docs 2>&1 | grep -vE "(DEPRECATION WARNING|More info and automated migrator|╷|│|╵|/workspaces/stream-of-thoughts/assets/main.scss)" || true
	@echo "alexdong.com" > docs/CNAME
	git add .
	@if git diff --cached --quiet; then \
		echo "No changes to publish."; \
	else \
		git commit -m "new post"; \
		git push; \
		echo "Site published successfully!"; \
	fi

build: deps ## Build the site into docs/ without deploying
	@echo "Building site into docs/..."
	@SASS_SILENCE_DEPRECATIONS=* $(BUNDLE) exec jekyll build -d docs 2>&1 | grep -vE "(DEPRECATION WARNING|More info and automated migrator|╷|│|╵|/workspaces/stream-of-thoughts/assets/main.scss)" || true
	@echo "alexdong.com" > docs/CNAME
	@echo "Site built at docs/"

dev: deps ## Start development server
	@echo "Starting Jekyll development server..."
	$(BUNDLE) exec jekyll serve --livereload --incremental

clean: ## Clean generated files
	@echo "Cleaning generated files..."
	$(BUNDLE) exec jekyll clean
	rm -rf docs/*

install: ## Install dependencies
	@echo "Installing Jekyll dependencies..."
	sudo apt-get update
	sudo apt-get install -y ruby-full build-essential
	sudo apt-get install -y bundler
	sudo apt-get install -y git-lfs
	git lfs install
	git lfs update --force
	$(BUNDLE) install
