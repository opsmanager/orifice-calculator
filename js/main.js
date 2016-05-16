(function() {
  require(['lib/shared-config'], function() {
    return require(['knockout', 'knockout.validation', 'ko-bindings', 'ko-extenders'], function(ko) {
      ko.validation.init();
      ko.components.register('orifice-calculator', {
        viewModel: {
          require: 'orifice-calculator-viewmodel'
        },
        template: {
          require: 'text!ko-components/templates/orifice-calculator.html'
        }
      });
      ko.validation.registerExtenders();
      return ko.applyBindings();
    });
  });

}).call(this);
