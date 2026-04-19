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

QUnit.test("supports option-based question structures for runtime rendering", (assert) => {
  const survey = new SurveyModel({
    id: "options-survey",
    questions: [
      { id: "q_select", type: "multiple_choice", label: "Select one", options: ["A", "B"] },
      { id: "q_check", type: "checkbox", label: "Pick many", options: ["X", "Y"] }
    ]
  });

  const questions = survey.get("questions");
  assert.equal(questions[0].options.length, 2);
  assert.equal(questions[1].options[0], "X");
});
