(function() {
  require(['lib/shared-config'], function() {
    requirejs.config({
      paths: {
        'jasmine': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.min",
        'jasmine-html': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine-html.min",
        'jasmine-boot': "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/boot.min",
        'jasmine-jquery': "lib/jasmine-jquery",
        'orifice-calculator-viewmodel-spec': 'ko-components/view-models/orifice-calculator-spec',
        'orifice-calculator-view-spec': 'ko-components/views/orifice-calculator-spec'
      },
      shim: {
        'jasmine-html': {
          deps: ['jasmine']
        },
        'jasmine-boot': {
          deps: ['jasmine-html']
        },
        'jasmine-jquery': {
          deps: ['jasmine-boot']
        }
      }
    });
    return require(['orifice-calculator-viewmodel-spec', 'orifice-calculator-view-spec', 'ko-bindings-spec'], function() {
      return window.onload();
    });
  });

}).call(this);
