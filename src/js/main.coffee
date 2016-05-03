# NOTE: Since main.js is using require.js, main.js should be
# loaded alongside require.js using the data-main attribute
# as per this: http://requirejs.org/docs/start.html

requirejs.config({
  paths: {
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
  }
})

require(['knockout'], (ko) ->
  ko.components.register('orifice-calculator', {
    viewModel: { require: 'js/orifice-calculator.js' }
    template: { require: 'text!_template.html' }
  })
  ko.applyBindings()
)
