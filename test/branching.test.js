const QUnit = require("qunit");
const SurveyModel = require("../src/coffee/models/SurveyModel.coffee");

QUnit.module("Branching logic");

QUnit.test("reveals conditional question based on answers", (assert) => {
  const survey = new SurveyModel({
    questions: [
      { id: "tools_access", type: "multiple_choice", label: "Tools?" },
      {
        id: "missing_tools",
        type: "checkbox",
        label: "Missing tools",
        condition: { dependsOn: "tools_access", operator: "not_equals", value: "Yes" }
      }
    ]
  });

  assert.false(survey.isVisible("missing_tools"));
  survey.setResponse("tools_access", "No");
  assert.true(survey.isVisible("missing_tools"));
});
