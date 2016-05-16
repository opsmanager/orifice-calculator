(function() {
  requirejs.config({
    paths: {
      'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min',
      'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    }
  });

  require(['knockout'], function(ko) {
    ko.components.register('orifice-calculator', {
      viewModel: {
        require: 'js/orifice-calculator.js'
      },
      template: {
        require: 'text!_template.html'
      }
    });
    return ko.applyBindings();
  });

}).call(this);
