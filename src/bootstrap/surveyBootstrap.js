import "../coffee/models/SurveyModel.coffee";
import "../coffee/views/SurveyView.coffee";
import "../coffee/services/VoiceService.coffee";
import "../coffee/services/ExportService.coffee";
import "../coffee/services/CopyPoisonService.coffee";
import "../coffee/services/BranchEngine.coffee";

function parseSurveyPayload(rawText) {
  if (!rawText || !rawText.trim()) {
    throw new Error("Survey definition is empty.");
  }

  const payload = JSON.parse(rawText);
  if (!payload || typeof payload !== "object") {
    throw new Error("Survey definition is not a valid object.");
  }

  if (!payload.id || typeof payload.id !== "string") {
    throw new Error("Survey definition is missing a valid id.");
  }

  if (!Array.isArray(payload.questions)) {
    throw new Error("Survey definition must include a questions array.");
  }

  return payload;
}

function renderBootstrapError(mountEl, message) {
  if (!mountEl) return;

  mountEl.innerHTML = `
    <div class="alert alert-danger" role="alert">
      Unable to load this survey. ${message}
    </div>
  `;
}

module.exports = {
  parseSurveyPayload,
  renderBootstrapError
};
