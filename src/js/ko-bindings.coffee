define 'ko-bindings', ['knockout', 'jquery'], (ko, $) ->
  ko.bindingHandlers.copyToClipboard =
    init: (element) ->
      $(element).on 'click', (event) ->
        temp = document.createElement 'input'
        temp.setAttribute 'value', element.innerHTML
        document.body.appendChild temp
        temp.select()
        document.execCommand 'copy'
        document.body.removeChild temp
