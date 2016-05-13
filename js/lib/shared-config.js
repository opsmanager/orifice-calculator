(function() {
  requirejs.config({
    baseUrl: '/js/',
    paths: {
      'jquery': 'https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min',
      'lodash': 'https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.12.0/lodash.min',
      'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min',
      'knockout.validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min',
      'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text',
      'orifice-calculator-viewmodel': 'ko-components/view-models/orifice-calculator',
      'orifice-calculator-config': 'ko-components/config/dictionaries'
    }
  });

}).call(this);
