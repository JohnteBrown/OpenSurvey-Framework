import "core-js/stable";
import "regenerator-runtime/runtime";
import $ from "jquery";
import Backbone from "backbone";
import "bootstrap/dist/css/bootstrap.min.css";
import "jquery-ui-dist/jquery-ui.min.css";
import "./less/main.less";
import templates from "./templates/questionTemplates.html";
import SurveyModel from "./coffee/models/SurveyModel.coffee";
import SurveyView from "./coffee/views/SurveyView.coffee";
import VoiceService from "./coffee/services/VoiceService.coffee";
const { parseSurveyPayload, renderBootstrapError } = require("./bootstrap/surveyBootstrap");

window.jQuery = $;
window.$ = $;
Backbone.$ = $;
require("jquery-ui-dist/jquery-ui");
require("bootstrap/dist/js/bootstrap.bundle");

const templateContainer = document.createElement("div");
templateContainer.innerHTML = templates;
document.body.appendChild(templateContainer);

const mountEl = document.getElementById("survey-app");
const surveyScript = document.getElementById("survey-definition");
if (!mountEl) {
  // Nothing to mount on this page.
} else if (!surveyScript) {
  renderBootstrapError(mountEl, "Survey data block was not found.");
} else {
  try {
    const surveyData = parseSurveyPayload(surveyScript.textContent);
    const surveyModel = new SurveyModel(surveyData);
    const voiceService = new VoiceService(Boolean(surveyData.voicePrompts));

    const surveyView = new SurveyView({
      el: "#survey-app",
      model: surveyModel,
      voiceService
    });

    surveyView.render();
  } catch (error) {
    renderBootstrapError(mountEl, error.message);
  }
}
