// =========================
// Survey Bootstrap Utilities (ESM)
// =========================

function parseSurveyPayload(rawText) {
  if (!rawText || !rawText.trim()) {
    throw new Error("Survey definition is empty.");
  }

  let payload;

  try {
    payload = JSON.parse(rawText);
  } catch (err) {
    throw new Error("Survey definition is not valid JSON.");
  }

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

export { parseSurveyPayload, renderBootstrapError };