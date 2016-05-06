requirejs.config({
  paths: {
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    'orifice-calculator-viewmodel': 'js/ko-components/view-models/orifice-calculator'
    'orifice-calculator-config': 'js/ko-components/config/dictionaries'
  }
})

require ['orifice-calculator-config', 'orifice-calculator-viewmodel'], ->
  ko.components.register('orifice-calculator', {
    viewModel: OPL.KoComponents.ViewModels.OrificeCalculator
    template: { require: 'text!js/ko-components/templates/orifice-calculator.html' }
  })
  ko.applyBindings()
