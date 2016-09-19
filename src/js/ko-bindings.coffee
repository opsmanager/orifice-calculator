define 'ko-bindings', ['knockout'], (ko) ->
  ko.bindingHandlers.copyToClipboard =
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      @callback = valueAccessor().callback
      element.onclick = () =>
        temp = document.createElement 'input'
        temp.setAttribute 'value', element.innerHTML
        document.body.appendChild temp
        temp.select()
        document.execCommand 'copy'
        document.body.removeChild temp

        @callback() if typeof @callback == 'function'
