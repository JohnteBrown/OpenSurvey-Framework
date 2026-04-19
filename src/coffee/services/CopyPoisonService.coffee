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
      script.async = true
      script.onload = -> resolve(true)
      script.onerror = -> resolve(false)
      document.head.appendChild(script)

    @_loadPromise

  @copy: async (text) ->
    await @ensureLoaded()

    if navigator?.clipboard?.writeText?
      await navigator.clipboard.writeText(text)
      return true

    temp = document.createElement("textarea")
    temp.value = text
    document.body.appendChild(temp)
    temp.select()
    success = document.execCommand("copy")
    document.body.removeChild(temp)
    success

module.exports = CopyPoisonService
