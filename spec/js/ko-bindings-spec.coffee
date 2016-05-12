define 'ko-bindings-spec', ['knockout', 'ko-bindings', 'jasmine-boot'], (ko) ->
  describe 'ko-bindings', ->
    viewModel = { copyText: ko.observable('copy to clipboard!') }
    mockElement = document.createElement 'div'
    fakeInput = document.createElement 'input'

    describe 'copyToClipboard', ->
      beforeEach ->
        spyOn(document, 'createElement').and.returnValue fakeInput
        spyOn(document, 'execCommand')
        spyOn(document.body, 'appendChild').and.callThrough()
        spyOn(document.body, 'removeChild').and.callThrough()
        $(mockElement).attr 'id', 'copy-text'
        $(mockElement).attr 'data-bind', 'copyToClipboard, text: copyText'
        ko.applyBindings viewModel, mockElement

      it 'should call the clipboard function', ->
        $(mockElement).click()
        expect(document.createElement).toHaveBeenCalled
        expect(document.body.appendChild).toHaveBeenCalledWith fakeInput
        expect(document.execCommand).toHaveBeenCalledWith 'copy'
        expect(fakeInput.value).toEqual 'copy to clipboard!'
        expect(document.body.removeChild).toHaveBeenCalledWith fakeInput
