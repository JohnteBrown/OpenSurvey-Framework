const QUnit = require("qunit");
const SurveyModel = require("../src/coffee/models/SurveyModel.coffee");

QUnit.module("Survey parsing");

QUnit.test("loads survey metadata and visibility defaults", (assert) => {
  const survey = new SurveyModel({
    id: "example",
    title: "Example Survey",
    description: "Test survey",
    questions: [
      { id: "q1", type: "text", label: "Q1" },
      { id: "q2", type: "text", label: "Q2", condition: { dependsOn: "q1", operator: "equals", value: "show" } }
    ]
  });

  assert.equal(survey.get("title"), "Example Survey");
  assert.true(survey.isVisible("q1"));
  assert.false(survey.isVisible("q2"));
});
