---
layout: page
title: Categories
permalink: /categories/
---

{%- if site.categories and site.categories != empty -%}
  {%- assign sorted_categories = site.categories | sort -%}
  {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
  <div class="category-archive">
    {%- for category in sorted_categories -%}
      {%- assign category_name = category[0] -%}
      {%- assign slug = category_name | slugify -%}
      <section id="{{ slug }}" class="category-group">
        <h2><a href="{{ '/categories/' | relative_url }}{{ slug }}/">{{ category_name }}</a></h2>
        {%- assign posts_in_category = category[1] -%}
        {%- include compact_post_list.html posts=posts_in_category show_excerpts=false date_format=date_format -%}
      </section>
    {%- endfor -%}
  </div>
{%- else -%}
  <p>No categories yet.</p>
{%- endif -%}
