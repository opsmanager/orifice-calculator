requirejs.config {
  paths:
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout.validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    'orifice-calculator-viewmodel': 'js/ko-components/view-models/orifice-calculator'
    'orifice-calculator-config': 'js/ko-components/config/dictionaries'
  shim:
    'knockout.validation':
      deps: ['knockout']
    'orifice-calculator-viewmodel':
      deps: ['orifice-calculator-config']
}

require ['knockout', 'knockout.validation', 'orifice-calculator-viewmodel'], (ko, validation) ->
  window.ko = ko
  ko.validation = validation
  ko.validation.init()
  ko.components.register 'orifice-calculator', {
    viewModel: OPL.KoComponents.ViewModels.OrificeCalculator
    template: { require: 'text!js/ko-components/templates/orifice-calculator.html' }
  }
  ko.validation.registerExtenders()
  ko.applyBindings()
