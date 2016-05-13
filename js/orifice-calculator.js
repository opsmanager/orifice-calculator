(function() {
  define(['knockout'], function(ko) {
    var OrificeCalculator;
    return OrificeCalculator = (function() {
      function OrificeCalculator() {
        var handleCommonKeydown;
        handleCommonKeydown = function(event) {
          if (_.includes([8, 9, 13, 27, 37, 38, 39, 40], event.keyCode)) {
            return;
          }
          if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57)) {
            return event.preventDefault();
          }
        };
        ko.bindingHandlers.onlyInteger = {
          init: function(element, valueAccessor) {
            return $(element).on('keydown', function(event) {
              return handleCommonKeydown(event);
            });
          }
        };
        ko.bindingHandlers.onlyFloat = {
          init: function(element, valueAccessor) {
            $(element).on('keydown', function(event) {
              if (event.keyCode === 190) {
                return;
              }
              return handleCommonKeydown(event);
            });
            return $(element).on('keypress', function(event) {
              if (event.keyCode === 46 && element.value.split('.').length === 2) {
                return event.preventDefault();
              }
            });
          }
        };
        this.pipeID = ko.observableArray(["2.067'' Sch 40, STD, Sch 40S", "1.939'' XS, Sch 80, Sch 80S", "2.157'' Sch 10, Sch 10S", "2.245'' Sch 5, Sch 5S", "1.687'' Sch 160", "1.503'' XXS"]);
        this.selectedPipeID = ko.observable(this.pipeID()[1]);
        this.operatingPressure = ko.observable();
        this.operatingPressureRead = ko.observableArray(['Gauge', 'Absolute']);
        this.chosenOperatingPressureRead = ko.observable(this.operatingPressureRead()[0]);
        this.operatingPressureUnits = ko.observableArray(['PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C']);
        this.selectedOperatingPressureUnits = ko.observable(this.operatingPressureUnits()[0]);
        this.baseSpecificGravity = ko.observable();
        this.operatingTemperature = ko.observable();
        this.operatingTemperatureUnit = ko.observableArray(['F', 'C']);
        this.selectedOperatingTemperatureUnit = ko.observable(this.operatingTemperatureUnit()[0]);
        this.differentialPressure = ko.observable();
        this.orificeBoreDiameter = ko.observable();
        this.compressibilityCorrection = ko.observableArray(['None', 'Zf']);
        this.chosenCompressibilityCorrection = ko.observable(this.compressibilityCorrection()[0]);
      }

      return OrificeCalculator;

    })();
  });

}).call(this);
