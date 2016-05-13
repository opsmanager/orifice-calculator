(function() {
  define(['text!_template.html'], function(template) {
    return describe('_template.html', function() {
      var itShouldBehaveLikeDropdownList, itShouldBehaveLikeRadioButtons, templateElements, tmp;
      tmp = document.implementation.createHTMLDocument();
      tmp.body.innerHTML = template;
      templateElements = tmp.body.children[0];
      itShouldBehaveLikeRadioButtons = function(elementArray) {
        return it('should be radio buttons', function() {
          return _.each(elementArray, function(el) {
            expect(el.tagName).toEqual('INPUT');
            return expect(el.getAttribute('type')).toEqual('radio');
          });
        });
      };
      itShouldBehaveLikeDropdownList = function(element) {
        return it('should be a dropdown list', function() {
          return expect(element.tagName).toEqual('SELECT');
        });
      };
      describe('Pipe ID', function() {
        var element;
        element = templateElements.querySelector('[data-bind="options: pipeID, value: selectedPipeID"]');
        return itShouldBehaveLikeDropdownList(element);
      });
      describe('Operating Pressure Units', function() {
        var element;
        element = templateElements.querySelector('[data-bind="options: operatingPressureUnits, value: selectedOperatingPressureUnits"]');
        return itShouldBehaveLikeDropdownList(element);
      });
      describe('Operating Pressure Read', function() {
        var elementArray;
        elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.chosenOperatingPressureRead"]');
        return itShouldBehaveLikeRadioButtons(elementArray);
      });
      describe('Operating Temperature Units', function() {
        var elementArray;
        elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.selectedOperatingTemperatureUnit"]');
        return itShouldBehaveLikeRadioButtons(elementArray);
      });
      return describe('Compressibility Correction', function() {
        var elementArray;
        elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.chosenCompressibilityCorrection"]');
        return itShouldBehaveLikeRadioButtons(elementArray);
      });
    });
  });

}).call(this);
