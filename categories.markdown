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
        <ul>
          {%- for post in category[1] -%}
            <li>
              <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
              <span class="post-meta">{{ post.date | date: date_format }}</span>
            </li>
          {%- endfor -%}
        </ul>
      </section>
    {%- endfor -%}
  </div>
{%- else -%}
  <p>No categories yet.</p>
{%- endif -%}
