class BranchEngine
  @evaluate: (question, responses = {}) ->
    return true unless question?.condition?

    condition = question.condition
    actual = responses[condition.dependsOn]
    expected = condition.value
    return false if actual is undefined or actual is null

    switch condition.operator
      when "equals" then actual is expected
      when "not_equals" then actual isnt expected
      when "includes" then Array.isArray(actual) and actual.indexOf(expected) isnt -1
      when "not_includes" then not (Array.isArray(actual) and actual.indexOf(expected) isnt -1)
      else true

module.exports = BranchEngine
