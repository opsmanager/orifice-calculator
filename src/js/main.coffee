requirejs.config {
  baseUrl: '/js/'
  paths:
    'lodash': 'https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.12.0/lodash.min'
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout.validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    'orifice-calculator-viewmodel': 'ko-components/view-models/orifice-calculator'
    'orifice-calculator-config': 'ko-components/config/dictionaries'
  shim:
    'knockout.validation':
      deps: ['knockout']
    'orifice-calculator-viewmodel':
      deps: ['knockout.validation', 'orifice-calculator-config']
}

require ['knockout', 'knockout.validation'], (ko) ->
  ko.validation.init()
  ko.components.register 'orifice-calculator', {
    viewModel:
      require: 'orifice-calculator-viewmodel'
    template:
      require: 'text!ko-components/templates/orifice-calculator.html'
  }
  ko.validation.registerExtenders()
  ko.applyBindings()
