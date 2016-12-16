(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define("orifice-calculator-viewmodel", ["knockout", "lodash", "knockout.validation", "orifice-calculator-config", "unit-converter"], function(ko, _) {
    var base, base1;
    this.OPL || (this.OPL = {});
    (base = this.OPL).KoComponents || (base.KoComponents = {});
    (base1 = this.OPL.KoComponents).ViewModels || (base1.ViewModels = {});
    return OPL.KoComponents.ViewModels.OrificeCalculator = (function() {
      var BASE_COMPRESSIBILITY, BASE_PRESSURE, BASE_TEMPERATURE, COEFFICIENT_OF_DISCHARGE, EXPANSION_FACTOR, UNIT_CONVERSION_FACTOR;

      UNIT_CONVERSION_FACTOR = 218.527;

      COEFFICIENT_OF_DISCHARGE = 0.6;

      EXPANSION_FACTOR = 1;

      BASE_TEMPERATURE = 519.67;

      BASE_PRESSURE = 14.73;

      BASE_COMPRESSIBILITY = 1;

      function OrificeCalculator() {
        this.copyFeedback = bind(this.copyFeedback, this);
        var config;
        config = OPL.OrificeCalculator.Config.Dictionaries;
        this.availablePipes = ko.observableArray(_.values(config.AvailablePipes));
        this.selectedPipeDiameter = ko.observable(config.AvailablePipes.oneNineInch.value);
        this.availablePressureUnits = ko.observable(config.PressureUnits);
        this.operatingPressure = ko.observable().extend({
          toNumber: true,
          required: {
            params: true,
            message: config.Messages.operatingPressureError
          },
          digit: {
            params: true,
            message: config.Messages.integerError
          }
        });
        this.operatingPressureRead = ko.observableArray(_.values(config.OperatingPressureRead));
        this.selectedOperatingPressureRead = ko.observable(config.OperatingPressureRead.gauge);
        this.selectedOperatingPressureUnit = ko.observable("psi");
        this.operatingPressureInPSI = ko.pureComputed((function(_this) {
          return function() {
            if (_this.selectedOperatingPressureUnit() === "psi") {
              return _this.operatingPressure();
            }
            return OPL.Converter.Pressure.convert(_this.selectedOperatingPressureUnit(), "psi", _this.operatingPressure());
          };
        })(this));
        this.operatingPressureWarningMessage = ko.pureComputed((function(_this) {
          return function() {
            var ref;
            switch (false) {
              case !((200 < (ref = _this.operatingPressureInPSI()) && ref <= 400)):
                return config.Messages.operatingPressureWarningMayResult;
              case !(401 <= _this.operatingPressureInPSI()):
                return config.Messages.operatingPressureWarningWillResult;
            }
          };
        })(this));
        this.availableBaseSpecificGravity = ko.observableArray(_.values(config.BaseSpecificGravity));
        this.baseSpecificGravity = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: config.Messages.floatError
          },
          required: {
            params: true,
            message: config.Messages.baseSpecificGravityError
          }
        });
        this.operatingTemperature = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: config.Messages.floatError
          },
          required: {
            params: true,
            message: config.Messages.operatingTemperatureError
          }
        });
        this.operatingTemperatureUnit = ko.observableArray(_.values(config.OperatingTemperatureUnits));
        this.selectedOperatingTemperatureUnit = ko.observable(config.OperatingTemperatureUnits.fahrenheit);
        this.differentialPressure = ko.observable().extend({
          toNumber: true,
          required: {
            params: true,
            message: config.Messages.differentialPressureError
          },
          digit: {
            params: true,
            message: config.Messages.integerError
          }
        });
        this.selectedDifferentialPressureUnit = ko.observable("inh2o");
        this.differentialPressureInInchesWater = ko.pureComputed((function(_this) {
          return function() {
            if (_this.selectedDifferentialPressureUnit() === "inh2o") {
              return _this.differentialPressure();
            }
            return OPL.Converter.Pressure.convert(_this.selectedDifferentialPressureUnit(), "inh2o", _this.differentialPressure());
          };
        })(this));
        this.orificeBoreDiameter = ko.observable().extend({
          toNumber: true,
          number: {
            params: true,
            message: config.Messages.floatError
          },
          required: {
            params: true,
            message: config.Messages.orificeBoreDiameterError
          }
        });
        this.availableBoreDiameterUnits = ko.observable(_.values(config.OrificeBoreDiameterUnits));
        this.selectedBoreDiameterUnit = ko.observable(config.OrificeBoreDiameterUnits.inches);
        this.orificeBoreDiameterInInches = ko.pureComputed((function(_this) {
          return function() {
            switch (_this.selectedBoreDiameterUnit()) {
              case config.OrificeBoreDiameterUnits.inches:
                return _this.orificeBoreDiameter();
              case config.OrificeBoreDiameterUnits.centimeters:
                return OPL.Converter.Dimensions.cmToInches(_this.orificeBoreDiameter());
              case config.OrificeBoreDiameterUnits.millimeters:
                return OPL.Converter.Dimensions.mmToInches(_this.orificeBoreDiameter());
            }
          };
        })(this));
        this.compressibilityCorrection = ko.observableArray(_.values(config.CompressibilityCorrection));
        this.selectedCompressibilityCorrection = ko.observable(config.CompressibilityCorrection.none);
        this.displayCompressibilityCorrection = ko.computed((function(_this) {
          return function() {
            return _this.selectedCompressibilityCorrection() !== config.CompressibilityCorrection.none;
          };
        })(this));
        this.compressibilityCorrectionValue = ko.observable(1);
        this.displayCompressibilityCorrection.subscribe((function(_this) {
          return function(isDisplayed) {
            if (!isDisplayed) {
              return _this.compressibilityCorrectionValue(1);
            }
          };
        })(this));
        this.betaRatio = ko.computed((function(_this) {
          return function() {
            var betaRatio;
            betaRatio = _.ceil(_this.orificeBoreDiameterInInches() / _this.selectedPipeDiameter(), 5);
            if (_.isNaN(betaRatio)) {
              return void 0;
            }
            return betaRatio;
          };
        })(this));
        this.velocityOfApproach = ko.computed((function(_this) {
          return function() {
            return _.ceil(1 / Math.sqrt(1 - Math.pow(_this.betaRatio(), 4)), 2);
          };
        })(this));
        this.availableFlowUnits = ko.observableArray(_.values(config.FlowRatePressureUnits));
        this.selectedFlowUnit = ko.observable(config.FlowRatePressureUnits.standardCubicFeet);
        this.availableFlowRateUnits = ko.observableArray(_.values(config.FlowRateTimeUnits));
        this.selectedFlowRateUnit = ko.observable(config.FlowRateTimeUnits.hour);
        this.operatingTemperatureInRankine = ko.pureComputed((function(_this) {
          return function() {
            switch (_this.selectedOperatingTemperatureUnit()) {
              case config.OperatingTemperatureUnits.fahrenheit:
                return OPL.Converter.Temperature.fToRankin(_this.operatingTemperature());
              case config.OperatingTemperatureUnits.celsius:
                return OPL.Converter.Temperature.cToRankin(_this.operatingTemperature());
            }
          };
        })(this));
        this.flowRate = ko.pureComputed((function(_this) {
          return function() {
            var flowRate;
            flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR * _this.velocityOfApproach() * Math.pow(_this.orificeBoreDiameterInInches(), 2) * BASE_TEMPERATURE / BASE_PRESSURE * Math.pow((_this.operatingPressureInPSI() * BASE_COMPRESSIBILITY * _this.differentialPressureInInchesWater()) / (_this.baseSpecificGravity() * _this.compressibilityCorrectionValue() * _this.operatingTemperatureInRankine()), 0.5);
            switch (_this.selectedFlowRateUnit()) {
              case config.FlowRateTimeUnits.day:
                flowRate *= 24;
                break;
              case config.FlowRateTimeUnits.minute:
                flowRate /= 60;
                break;
              case config.FlowRateTimeUnits.second:
                flowRate /= 3600;
            }
            if (_this.selectedFlowUnit() !== config.FlowRatePressureUnits.standardCubicFeet) {
              flowRate = OPL.Converter.FlowRate.convert(config.FlowRatePressureUnits.standardCubicFeet, _this.selectedFlowUnit(), flowRate);
            }
            if (_.isNaN(flowRate)) {
              return void 0;
            } else {
              return _.ceil(flowRate, 3);
            }
          };
        })(this));
        this.copyFeedbackActive = ko.observable(false);
        this.copyFeedbackClass = ko.pureComputed((function(_this) {
          return function() {
            if (_this.copyFeedbackActive()) {
              return 'bounce-in';
            } else {
              return 'hidden';
            }
          };
        })(this));
      }

      OrificeCalculator.prototype.copyFeedback = function() {
        this.copyFeedbackActive(true);
        return setTimeout((function(_this) {
          return function() {
            return _this.copyFeedbackActive(false);
          };
        })(this), 1000);
      };

      return OrificeCalculator;

    })();
  });

}).call(this);
