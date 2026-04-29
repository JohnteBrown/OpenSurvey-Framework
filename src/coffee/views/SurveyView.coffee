$ = require("jquery")
Backbone = require("backbone")

require("jsrender")
require("jsviews")($)

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
    @template = null
    @templateError = null

    try
      tplEl = $("#survey-template")

      if !tplEl.length
        throw new Error("Missing #survey-template in DOM")

      templateHtml = tplEl.html()
      @template = $.templates(templateHtml)

    catch err
      @templateError = err

    @listenTo(@model, "change", @render)

  renderErrorState: (message) ->
    @$el.html("""
      <div class='alert alert-danger' role='alert'>
        #{message}
      </div>
    """)
    @

  render: ->
    if @templateError?
      return @renderErrorState("Template error: " + @templateError.message)

    if !@template?
      return @renderErrorState("Survey template not available.")

    try
      data = @model.toJSON()
      responses = data.responses or {}

      html = @template.render(data,
        isVisible: (id) =>
          @model.isVisible(id)

        value: (id) =>
          v = responses[id]
          if Array.isArray(v) then "" else v

        selected: (id, opt) =>
          responses[id] is opt

        checked: (id, opt) =>
          vals = responses[id] or []
          Array.isArray(vals) and vals.indexOf(opt) isnt -1
      )

      @$el.html(html)
      @initSliders()
      @

    catch err
      console.error("Render error:", err)
      @renderErrorState("Unable to render survey questions.")

  initSliders: ->
    view = @
    return unless $.fn?.slider?

    @$el.find(".rating-slider").each ->
      sliderEl = $(this)
      qid = sliderEl.attr("id")?.replace("-slider", "")
      return unless qid?

      input = view.$el.find("##{qid}")
      return unless input.length

      currentValue = Number(input.val() or 3)

      sliderEl.slider
        min: 1
        max: 5
        value: currentValue
        slide: (_e, ui) ->
          input.val(ui.value).trigger("input")
          input.closest(".question-block")
            .find(".rating-display")
            .text(ui.value)

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
    questions = @model.get("questions") or []

    firstVisible = questions.find (q) =>
      @model.isVisible(q.id)

    return unless firstVisible?
    return unless @voiceService?.readText?

    @voiceService.readText(firstVisible.label)

  handleKeyboardNav: (event) ->
    return unless event.key is "Enter"

    event.preventDefault()
    event.stopPropagation()

    inputs = @$el.find(".survey-input:visible")
    index = inputs.index(event.currentTarget)
    next = inputs.get(index + 1)

    if next?
      next.focus()

module.exports = SurveyView