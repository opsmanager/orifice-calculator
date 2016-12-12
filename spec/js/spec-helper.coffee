require ["lib/shared-config"], ->
  requirejs.config {
    paths:
      "jasmine": "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine.min"
      "jasmine-html": "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/jasmine-html.min"
      "jasmine-boot": "https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.4.1/boot.min"
      "jasmine-jquery": "lib/jasmine-jquery"
      "orifice-calculator-viewmodel-spec": "ko-components/view-models/orifice-calculator-spec"
      "orifice-calculator-view-spec": "ko-components/views/orifice-calculator-spec"
      "unit-converter-spec": "lib/converter-spec"
    shim:
      # NOTE: These libraries need to be shimed.
      # They do not express their dependencies with "define()"
      "jasmine-html":
        deps: ["jasmine"]
      "jasmine-boot":
        deps: ["jasmine-html"]
      "jasmine-jquery":
        deps: ["jasmine-boot"]
  }

  require ["orifice-calculator-viewmodel-spec", "orifice-calculator-view-spec", "ko-bindings-spec", "unit-converter-spec"], () ->
    window.onload()
