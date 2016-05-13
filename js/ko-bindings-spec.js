(function() {
  define('ko-bindings-spec', ['knockout', 'ko-bindings', 'jasmine-boot'], function(ko) {
    return describe('ko-bindings', function() {
      var fakeInput, mockElement, viewModel;
      viewModel = {
        copyText: ko.observable('copy to clipboard!')
      };
      mockElement = document.createElement('div');
      fakeInput = document.createElement('input');
      return describe('copyToClipboard', function() {
        beforeEach(function() {
          spyOn(document, 'createElement').and.returnValue(fakeInput);
          spyOn(document, 'execCommand');
          spyOn(document.body, 'appendChild').and.callThrough();
          spyOn(document.body, 'removeChild').and.callThrough();
          $(mockElement).attr('id', 'copy-text');
          $(mockElement).attr('data-bind', 'copyToClipboard, text: copyText');
          return ko.applyBindings(viewModel, mockElement);
        });
        return it('should call the clipboard function', function() {
          $(mockElement).click();
          expect(document.createElement).toHaveBeenCalled;
          expect(document.body.appendChild).toHaveBeenCalledWith(fakeInput);
          expect(document.execCommand).toHaveBeenCalledWith('copy');
          expect(fakeInput.value).toEqual('copy to clipboard!');
          return expect(document.body.removeChild).toHaveBeenCalledWith(fakeInput);
        });
      });
    });
  });

}).call(this);
