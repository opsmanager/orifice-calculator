define 'ko-bindings', ['knockout'], (ko) ->
  ko.bindingHandlers.copyToClipboard =
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      @callback = valueAccessor()?.callback

      element.onclick = () =>
        temp = document.createElement 'input'
        nestedElement = _findNestedValue element
        temp.setAttribute 'value', nestedElement.innerHTML
        document.body.appendChild temp
        temp.select()
        document.execCommand 'copy'
        document.body.removeChild temp

        @callback() if typeof @callback == 'function'

      _findNestedValue = (element) ->
        if element.children.length > 0
          lastChildren = element.children[0]
          while lastChildren.children.length != 0
            lastChildren = lastChildren.children[0]
        else
          lastChildren = element

        lastChildren
