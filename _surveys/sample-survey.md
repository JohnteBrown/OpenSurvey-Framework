---
layout: default
title: Sample Survey
---

<section class="survey-shell">
  <h1 class="h3 mb-2">{{ site.data.surveys.sample-survey.title }}</h1>
  <p class="text-muted mb-4">{{ site.data.surveys.sample-survey.description }}</p>
  <div id="survey-app"></div>
</section>

<script id="survey-definition" type="application/json">{{ site.data.surveys.sample-survey | jsonify }}</script>
