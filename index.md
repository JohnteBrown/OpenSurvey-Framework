---
layout: default
title: Survey Framework Prototype
---

<section class="survey-shell">
  <h1 class="h3 mb-2">Survey Framework Prototype</h1>
  <p class="text-muted mb-4">Dynamic, data-driven surveys rendered from Jekyll-managed definitions.</p>
  <div id="survey-app"></div>
</section>

<script id="survey-definition" type="application/json">{{ site.data.surveys.sample-survey | jsonify }}</script>
