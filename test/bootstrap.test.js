const QUnit = require("qunit");
const { parseSurveyPayload } = require("../src/bootstrap/surveyBootstrap");

QUnit.module("Bootstrap payload parsing");

QUnit.test("parses valid survey payload", (assert) => {
  const parsed = parseSurveyPayload(
    JSON.stringify({
      id: "survey-1",
      questions: [{ id: "q1", type: "text", label: "Name" }]
    })
  );

  assert.equal(parsed.id, "survey-1");
  assert.equal(parsed.questions.length, 1);
});

QUnit.test("throws for malformed or incomplete payload", (assert) => {
  assert.throws(() => parseSurveyPayload(""), /empty/i);
  assert.throws(() => parseSurveyPayload("{\"id\":\"only\"}"), /questions array/i);
  assert.throws(() => parseSurveyPayload("{bad-json"), /Unexpected token|JSON/i);
});
