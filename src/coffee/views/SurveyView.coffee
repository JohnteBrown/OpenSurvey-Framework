$ = require("jquery")
Backbone = require("backbone")
jsrender = require("jsrender")
require("jsviews")
ExportService = require("../services/ExportService")
CopyPoisonService = require("../services/CopyPoisonService")

class SurveyView extends Backbone.View
  events:
    "input .survey-input": "handleInput"
    "change .survey-checkbox": "handleCheckboxChange"
    "click #submit-survey": "handleSubmit"
    "click #copy-json": "copyJson"
    "click #copy-csv": "copyCsv"
    "click #voice-read": "readCurrentQuestion"
    "keydown .survey-input": "handleKeyboardNav"

  initialize: (options) ->
    @voiceService = options.voiceService
    @template = $.templates("#survey-template")
    @listenTo(@model, "change", @render)

  render: ->
    html = @template.render(@model.toJSON(),
      isVisible: (id) => @model.isVisible(id)
      value: (id) =>
        value = @model.get("responses")[id]
        if Array.isArray(value) then "" else value
      checked: (id, opt) =>
        values = @model.get("responses")[id] or []
        Array.isArray(values) and values.indexOf(opt) isnt -1
    )

    @$el.html(html)
    @initSliders()
    @

  initSliders: ->
    view = @
    @$el.find(".rating-slider").each ->
      sliderEl = $(this)
      qid = sliderEl.attr("id").replace("-slider", "")
      input = view.$el.find("##{qid}")
      currentValue = Number(input.val() or 3)

      sliderEl.slider
        min: 1
        max: 5
        value: currentValue
        slide: (_event, ui) ->
          input.val(ui.value).trigger("input")
          input.closest(".question-block").find(".rating-display").text(ui.value)

  handleInput: (event) ->
    target = $(event.currentTarget)
    @model.setResponse(target.attr("id"), target.val())

  handleCheckboxChange: (event) ->
    checkbox = $(event.currentTarget)
    questionId = checkbox.data("question-id")
    checkedValues = []
    @$el.find(".survey-checkbox[data-question-id='#{questionId}']:checked").each ->
      checkedValues.push($(this).val())
    @model.setResponse(questionId, checkedValues)

  handleSubmit: ->
    @model.set("submissionOutput", ExportService.toJSON(@model))

  copyJson: ->
    CopyPoisonService.copy(ExportService.toJSON(@model))

  copyCsv: ->
    CopyPoisonService.copy(ExportService.toCSV(@model))

  readCurrentQuestion: ->
    firstVisible = (@model.get("questions") or []).find((question) => @model.isVisible(question.id))
    return unless firstVisible?
    @voiceService.readText(firstVisible.label)

  handleKeyboardNav: (event) ->
    return unless event.key is "Enter"
    inputs = @$el.find(".survey-input:visible")
    index = inputs.index(event.currentTarget)
    nextInput = inputs.get(index + 1)
    if nextInput?
      nextInput.focus()
      event.preventDefault()

module.exports = SurveyView
