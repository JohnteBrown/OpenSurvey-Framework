class ExportService
  @toJSON: (surveyModel) ->
    payload =
      surveyId: surveyModel.get("id")
      submittedAt: new Date().toISOString()
      responses: surveyModel.get("responses")

    JSON.stringify(payload, null, 2)

  @toCSV: (surveyModel) ->
    responses = surveyModel.get("responses") or {}
    rows = [["question_id", "response"]]

    for key, value of responses
      rendered = if Array.isArray(value) then value.join("|") else value
      rows.push([key, "#{rendered or ""}"])

    rows
      .map((row) -> row.map((value) -> "\"#{("#{value}".replace(/"/g, "\"\""))}\"").join(","))
      .join("\n")

module.exports = ExportService
