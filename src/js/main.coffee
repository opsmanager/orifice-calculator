# NOTE: Since main.js is using require.js, main.js should be
# loaded alongside require.js using the data-main attribute
# as per this: http://requirejs.org/docs/start.html

requirejs.config({
  paths: {
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout-validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text.min'
  }
  shim: {
    'knockout-validation': {
      deps: ['knockout']
    }
  }
})

require(['knockout'], (ko) ->
  ko.components.register('orifice-calculator', {
    viewModel: { require: 'js/orifice-calculator.js' }
    template: { require: 'text!_template.html' }
  })
  ko.applyBindings()
)
