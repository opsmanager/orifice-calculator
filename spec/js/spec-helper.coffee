requirejs.config {
  baseUrl: '/js/'
  paths:
    'lodash': 'https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.12.0/lodash.min'
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout.validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    'jasmine': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.min"
    'jasmine-html': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine-html.min"
    'jasmine-boot': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/boot.min"
    'jasmine-jquery': "lib/jasmine-jquery"
    'jquery': 'https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min'
    'orifice-calculator-viewmodel': 'ko-components/view-models/orifice-calculator'
    'orifice-calculator-config': 'ko-components/config/dictionaries'
    'orifice-calculator-viewmodel-spec': 'ko-components/view-models/orifice-calculator-spec'
    'orifice-calculator-view-spec': 'ko-components/views/orifice-calculator-spec'
  shim:
    'jasmine-html':
      deps: ['jasmine']
    'jasmine-boot':
      deps: ['jasmine-html']
    'jasmine-jquery':
      deps: ['jasmine-boot', 'jquery']
    'knockout.validation':
      deps: ['knockout']
    'orifice-calculator-viewmodel':
      deps: ['knockout.validation', 'orifice-calculator-config']
    'orifice-calculator-viewmodel-spec':
      deps: ['orifice-calculator-viewmodel']
    'orifice-calculator-view-spec':
      deps: ['jasmine-jquery']
}

require ['orifice-calculator-viewmodel-spec', 'orifice-calculator-view-spec'], () ->
    window.onload()
