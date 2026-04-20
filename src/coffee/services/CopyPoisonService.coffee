class CopyPoisonService
  @scriptUrl: "https://copypoison.com/cp.js"
  @_loadPromise: null

  @ensureLoaded: ->
    return Promise.resolve(false) unless document?
    return @_loadPromise if @_loadPromise?

    @_loadPromise = new Promise (resolve) =>
      existing = document.querySelector("script[src='#{@scriptUrl}']")
      if existing?
        resolve(true)
        return

      script = document.createElement("script")
      script.src = @scriptUrl
      script.onload = -> resolve(true)
      script.onerror = -> resolve(false)
      document.head.appendChild(script)

    @_loadPromise

  @copy: (text) ->
    CopyPoisonService.ensureLoaded().then =>
      if navigator?.clipboard?.writeText?
        return navigator.clipboard.writeText(text).then -> true

      temp = document.createElement("textarea")
      temp.value = text
      document.body.appendChild(temp)
      temp.select()
      success = document.execCommand("copy")
      document.body.removeChild(temp)
      success

module.exports = CopyPoisonService