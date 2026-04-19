const QUnit = require("qunit");
const SurveyModel = require("../src/coffee/models/SurveyModel.coffee");
const ExportService = require("../src/coffee/services/ExportService.coffee");

QUnit.module("Export service");

QUnit.test("exports valid JSON and CSV output", (assert) => {
  const survey = new SurveyModel({
    id: "export-check",
    questions: [{ id: "q1", type: "text", label: "Q1" }]
  });

  survey.setResponse("q1", "hello");
  const json = ExportService.toJSON(survey);
  const csv = ExportService.toCSV(survey);

  assert.true(json.includes("\"q1\": \"hello\""));
  assert.true(csv.includes("\"q1\",\"hello\""));
});
