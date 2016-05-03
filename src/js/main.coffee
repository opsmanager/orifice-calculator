# NOTE: Since main.js is using require.js, main.js should be
# loaded alongside require.js using the data-main attribute
# as per this: http://requirejs.org/docs/start.html

@App = ViewModels: {}
requirejs.config({
  paths: {
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
  }
})
ko.components.register('orifice-calculator', {
  template: { require: 'text!_template.html' }
})
ko.applyBindings()
