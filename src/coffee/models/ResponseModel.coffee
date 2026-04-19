Backbone = require("backbone")

class ResponseModel extends Backbone.Model
  defaults: ->
    values: {}

  setValue: (key, value) ->
    values = Object.assign({}, @get("values"))
    values[key] = value
    @set("values", values)

  getValue: (key) ->
    @get("values")[key]

module.exports = ResponseModel
