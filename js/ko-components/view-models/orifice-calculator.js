(function() {
  define('orifice-calculator-viewmodel', ['knockout', 'lodash', 'knockout.validation', 'orifice-calculator-config'], function(ko, _) {
    var base, base1;
    this.OPL || (this.OPL = {});
    (base = this.OPL).KoComponents || (base.KoComponents = {});
    (base1 = this.OPL.KoComponents).ViewModels || (base1.ViewModels = {});
    return OPL.KoComponents.ViewModels.OrificeCalculator = (function() {
      var ABSOLUTE_ZERO, BASE_COMPRESSIBILITY, BASE_PRESSURE, BASE_TEMPERATURE, COEFFICIENT_OF_DISCHARGE, EXPANSION_FACTOR, UNIT_CONVERSION_FACTOR;

      UNIT_CONVERSION_FACTOR = 218.527;

      COEFFICIENT_OF_DISCHARGE = 0.6;

      EXPANSION_FACTOR = 1;

      BASE_TEMPERATURE = 519.67;

      BASE_PRESSURE = 14.73;

      BASE_COMPRESSIBILITY = 1;

      ABSOLUTE_ZERO = 459.67;

      function OrificeCalculator() {
        this.availablePipes = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes));
        this.selectedPipeDiameter = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
        this.operatingPressure = ko.observable().extend({
          toNumber: true,
          required: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureError
          },
          digit: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integerError
          }
        });
        this.operatingPressureWarningMessage = ko.pureComputed((function(_this) {
          return function() {
            var ref;
            switch (false) {
              case !((200 < (ref = _this.operatingPressure()) && ref <= 400)):
                return OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult;
              case !(401 <= _this.operatingPressure()):
                return OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningWillResult;
            }
          };
        })(this));
        this.operatingPressureRead = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead));
        this.selectedOperatingPressureRead = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge);
        this.operatingPressureUnits = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits));
        this.selectedOperatingPressureUnits = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits.psi);
        this.baseSpecificGravity = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
          },
          required: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.baseSpecificGravityError
          }
        });
        this.operatingTemperature = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
          },
          required: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingTemperatureError
          }
        });
        this.operatingTemperatureUnit = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits));
        this.selectedOperatingTemperatureUnit = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit);
        this.differentialPressure = ko.observable().extend({
          toNumber: true,
          required: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.differentialPressureError
          },
          digit: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integerError
          }
        });
        this.orificeBoreDiameter = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
          },
          required: {
            params: true,
            message: OPL.OrificeCalculator.Config.Dictionaries.Messages.orificeBoreDiameterError
          }
        });
        this.compressibilityCorrection = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection));
        this.selectedCompressibilityCorrection = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none);
        this.displayCompressibilityCorrection = ko.computed((function(_this) {
          return function() {
            return _this.selectedCompressibilityCorrection() !== OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none;
          };
        })(this));
        this.compressibilityCorrectionValue = ko.observable();
        this.displayCompressibilityCorrection.subscribe((function(_this) {
          return function(newValue) {
            if (newValue) {
              return _this.compressibilityCorrectionValue(1);
            } else {
              return _this.compressibilityCorrectionValue(void 0);
            }
          };
        })(this));
        this.betaRatio = ko.computed((function(_this) {
          return function() {
            return _.ceil(_this.orificeBoreDiameter() / _this.selectedPipeDiameter(), 4);
          };
        })(this));
        this.velocityOfApproach = ko.computed((function(_this) {
          return function() {
            return _.ceil(1 / Math.sqrt(1 - Math.pow(_this.betaRatio(), 4)), 2);
          };
        })(this));
        this.availableFlowRateUnits = ko.observableArray(_.values(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits));
        this.selectedFlowRateUnit = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute);
        this.flowRate = ko.computed((function(_this) {
          return function() {
            var flowRate, operatingTemperatureInRankine;
            operatingTemperatureInRankine = _this.operatingTemperature() + ABSOLUTE_ZERO;
            flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR * _this.velocityOfApproach() * Math.pow(_this.orificeBoreDiameter(), 2) * BASE_TEMPERATURE / BASE_PRESSURE * Math.pow((_this.operatingPressure() * BASE_COMPRESSIBILITY * _this.differentialPressure()) / (_this.baseSpecificGravity() * _this.compressibilityCorrectionValue() * operatingTemperatureInRankine), 0.5);
            switch (_this.selectedFlowRateUnit()) {
              case OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.day:
                flowRate *= 24;
                break;
              case OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute:
                flowRate /= 60;
                break;
              case OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.second:
                flowRate /= 3600;
            }
            operatingTemperatureInRankine = Number(_this.operatingTemperature()) + ABSOLUTE_ZERO;
            return _.ceil(flowRate, 3);
          };
        })(this));
      }

      return OrificeCalculator;

    })();
  });

}).call(this);
