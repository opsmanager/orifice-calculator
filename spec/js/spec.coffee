require.config({
  paths: {
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout-validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text.min'
    'jasmine': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.min"
    'jasmine-html': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine-html.min"
    'jasmine-boot': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/boot.min"
  }
  shim: {
    'jasmine-html': {
      deps: ['jasmine']
    }
    'jasmine-boot': {
      deps: ['jasmine-html']
    }
  }
})

require(['jasmine-boot'], () ->
  require(['js/orifice-calculator_spec.js', 'js/_template_spec.js'], () ->
    window.onload()
  )
)
