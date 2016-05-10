define 'ko-bindings', ['knockout'], (ko) ->
  ko.bindingHandlers.copyToClipboard =
    init: (element) ->
      element.onclick = () ->
        temp = document.createElement 'input'
        temp.setAttribute 'value', element.innerHTML
        document.body.appendChild temp
        temp.select()
        document.execCommand 'copy'
        document.body.removeChild temp
