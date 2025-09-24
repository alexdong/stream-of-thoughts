# frozen_string_literal: true

module Jekyll
  # Generate a lightweight page for each category so links like
  # /categories/ruby/ render without manual maintenance.
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      process(@name)
      read_yaml(File.join(base, "_layouts"), "category.html")

      self.data["category"] = category
      self.data["title"] = category
      self.data["slug"] = Utils.slugify(category)
      self.data["permalink"] = File.join("/categories", "#{data["slug"]}/")
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      return if site.categories.empty?

      site.categories.keys.sort.each do |category|
        slug = Utils.slugify(category)
        dir = File.join("categories", slug)
        site.pages << CategoryPage.new(site, site.source, dir, category)
      end
    end
  end
end
