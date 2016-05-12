require ['lib/shared-config'], ->
  require ['knockout', 'knockout.validation', 'ko-bindings'], (ko) ->
    ko.validation.init()
    ko.components.register 'orifice-calculator', {
      viewModel:
        require: 'orifice-calculator-viewmodel'
      template:
        require: 'text!ko-components/templates/orifice-calculator.html'
    }
    ko.validation.registerExtenders()
    ko.applyBindings()
