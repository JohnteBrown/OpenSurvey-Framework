Backbone = require("backbone")
_ = require("underscore")
BranchEngine = require("../services/BranchEngine")

class SurveyModel extends Backbone.Model
  defaults: ->
    id: ""
    title: ""
    description: ""
    questions: []
    responses: {}
    visibleQuestionIds: []
    submissionOutput: "{}"
    voicePrompts: false

  initialize: ->
    @recalculateVisibility()

  setResponse: (questionId, value) ->
    responses = _.clone(@get("responses"))
    responses[questionId] = value
    @set("responses", responses)
    @recalculateVisibility()

  recalculateVisibility: ->
    responses = @get("responses")
    visible = (@get("questions") or [])
      .filter((question) -> BranchEngine.evaluate(question, responses))
      .map((question) -> question.id)
    @set("visibleQuestionIds", visible)

  isVisible: (questionId) ->
    @get("visibleQuestionIds").indexOf(questionId) isnt -1

module.exports = SurveyModel
