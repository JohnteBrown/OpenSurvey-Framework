class VoiceService
  constructor: (@enabled = false) ->

  readText: (text) ->
    return unless @enabled
    return unless text?
    if window?.responsiveVoice?.speak?
      window.responsiveVoice.speak(text)

module.exports = VoiceService
