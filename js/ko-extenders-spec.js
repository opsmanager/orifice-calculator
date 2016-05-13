(function() {
  define('ko-extenders-spec', ['knockout', 'jasmine-boot', 'ko-extenders'], function(ko) {
    return describe('ko-extenders', function() {
      return it('should return Number when toNumber extender is used', function() {
        var viewModel;
        viewModel = {
          numberField: ko.observable().extend({
            toNumber: true
          })
        };
        viewModel.numberField('123e1');
        return expect(typeof viewModel.numberField()).toEqual('number');
      });
    });
  });

}).call(this);
