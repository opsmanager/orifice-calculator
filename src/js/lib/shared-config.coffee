requirejs.config {
  # NOTE: The baseUrl does not begin with a backslash in the
  # case we need to host it on a subfolder. For example,
  # http://server/subfolder
  baseUrl: 'js/'
  paths:
    # NOTE: ko-bindings and ko-extenders is not declared in "paths"
    # because the namespace and the filenames are the same
    'jquery': 'https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min'
    'lodash': 'https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.12.0/lodash.min'
    'cookies': 'https://cdnjs.cloudflare.com/ajax/libs/js-cookie/2.1.3/js.cookie.min'
    'knockout': 'https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min'
    'knockout.validation': 'https://cdnjs.cloudflare.com/ajax/libs/knockout-validation/2.0.3/knockout.validation.min'
    'text': 'https://cdnjs.cloudflare.com/ajax/libs/require-text/2.0.12/text'
    'orifice-calculator-viewmodel': 'ko-components/view-models/orifice-calculator'
    'orifice-calculator-config': 'ko-components/config/dictionaries'
    'unit-converter': 'lib/converter'
}
