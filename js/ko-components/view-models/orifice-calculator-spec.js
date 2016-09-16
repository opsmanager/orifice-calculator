(function() {
  define('orifice-calculator-viewmodel-spec', ['knockout', 'jquery', 'jasmine-boot', 'orifice-calculator-viewmodel'], function(ko, $) {
    return describe('orifice-calculator-viewmodel-spec', function() {
      var itBehavesLikeFloatField, itBehavesLikeIntegerField, itBehavesLikeMandatoryField, viewModel;
      viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator();
      itBehavesLikeMandatoryField = function(field) {
        return it('has mandatory field validation', function() {
          field('');
          return expect(field.isValid()).toEqual(false);
        });
      };
      itBehavesLikeIntegerField = function(field) {
        return it('should only accept integer', function() {
          field(123);
          expect(field.isValid()).toEqual(true);
          field(123.456);
          expect(field.isValid()).toEqual(false);
          field('123abc');
          return expect(field.isValid()).toEqual(false);
        });
      };
      itBehavesLikeFloatField = function(field) {
        return it('should only accept float', function() {
          field(123);
          expect(field.isValid()).toEqual(true);
          field(123.456);
          expect(field.isValid()).toEqual(true);
          field('123abc');
          return expect(field.isValid()).toEqual(false);
        });
      };
      describe('viewModel', function() {
        return it('should be invalid when it does not contain valid fields', function() {
          viewModel.operatingPressure('abc123');
          return expect(ko.validatedObservable(viewModel).isValid()).toEqual(false);
        });
      });
      describe('availablePipes', function() {
        it('should have initialized the input data', function() {
          return expect(viewModel.availablePipes().length).toEqual(6);
        });
        return it('should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', function() {
          return expect(viewModel.selectedPipeDiameter()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
        });
      });
      describe('operatingPressure', function() {
        itBehavesLikeMandatoryField(viewModel.operatingPressure);
        itBehavesLikeIntegerField(viewModel.operatingPressure);
        describe('when pressure is high', function() {
          it('should display a operatingPressureWarning message at > 200', function() {
            viewModel.operatingPressure(201);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult);
          });
          it('should display a operatingPressureWarning message at < 401', function() {
            viewModel.operatingPressure(400);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult);
          });
          return it('should display an operatingPressureError message at > 400', function() {
            viewModel.operatingPressure(401);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningWillResult);
          });
        });
        return describe('when pressure is low', function() {
          return it('should not have any messages', function() {
            viewModel.operatingPressure(100);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(void 0);
          });
        });
      });
      describe('operatingPressureRead', function() {
        it('should have "Gauge" and "Absolute"', function() {
          return expect(viewModel.operatingPressureRead()).toEqual(_.values(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead));
        });
        return it('should have default value of "Gauge"', function() {
          return expect(viewModel.selectedOperatingPressureRead()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge);
        });
      });
      describe('baseSpecificGravity', function() {
        itBehavesLikeMandatoryField(viewModel.baseSpecificGravity);
        return itBehavesLikeFloatField(viewModel.baseSpecificGravity);
      });
      describe('operatingTemperature', function() {
        itBehavesLikeMandatoryField(viewModel.operatingTemperature);
        return itBehavesLikeFloatField(viewModel.operatingTemperature);
      });
      describe('operatingTemperatureUnits', function() {
        it('should have default value of "Fahrenheit"', function() {
          return expect(viewModel.selectedOperatingTemperatureUnit()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit);
        });
        return it('should have Fahrenheit and Celsius for operating temperature unit', function() {
          return expect(viewModel.operatingTemperatureUnit()).toEqual(_.values(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits));
        });
      });
      describe('differentialPressure', function() {
        itBehavesLikeMandatoryField(viewModel.differentialPressure);
        return itBehavesLikeIntegerField(viewModel.differentialPressure);
      });
      describe('orificeBoreDiameter', function() {
        itBehavesLikeMandatoryField(viewModel.orificeBoreDiameter);
        return itBehavesLikeFloatField(viewModel.orificeBoreDiameter);
      });
      describe('compressibilityCorrection', function() {
        it('should have a default value of "None"', function() {
          return expect(viewModel.selectedCompressibilityCorrection()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none);
        });
        return it('should have None and Zf for compressibility correction', function() {
          return expect(viewModel.compressibilityCorrection()).toEqual(_.values(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection));
        });
      });
      describe('displayCompressibilityCorrection', function() {
        describe('when compressibilityCorrection is none', function() {
          return it('is false', function() {
            viewModel.selectedCompressibilityCorrection(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none);
            return expect(viewModel.displayCompressibilityCorrection()).toEqual(false);
          });
        });
        return describe('when compressibilityCorrection is not none', function() {
          return it('is true', function() {
            viewModel.selectedCompressibilityCorrection(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.zf);
            return expect(viewModel.displayCompressibilityCorrection()).toEqual(true);
          });
        });
      });
      describe('betaRatio', function() {
        return it('should return beta ratio', function() {
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.twoZeroInch.value);
          viewModel.orificeBoreDiameter(0.97);
          return expect(viewModel.betaRatio()).toEqual(0.4693);
        });
      });
      describe('velocityOfApproach', function() {
        return it('should return velocity of approach', function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
          expect(viewModel.velocityOfApproach()).toEqual(1.04);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
          return expect(viewModel.velocityOfApproach()).toEqual(1.02);
        });
      });
      describe('flowRate', function() {
        return it('should return the flow rate', function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute);
          expect(viewModel.flowRate()).toEqual(543.783);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute);
          return expect(viewModel.flowRate()).toEqual(341.328);
        });
      });
      describe('availableAvailableFlowRateUnits', function() {
        it('should have initialized the input data', function() {
          return expect(viewModel.availableFlowRateUnits().length).toEqual(4);
        });
        return it('should have default value of "Minutes"', function() {
          return expect(viewModel.selectedFlowRateUnit()).toEqual(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute);
        });
      });
      return describe('selectedFlowRateUnit', function() {
        beforeEach(function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          return viewModel.operatingTemperature(60);
        });
        it('when minute is chosen', function() {
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.minute);
          return expect(viewModel.flowRate()).toEqual(543.783);
        });
        it('when hour is chosen', function() {
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.hour);
          return expect(viewModel.flowRate()).toEqual(32626.924);
        });
        it('when day is chosen', function() {
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.day);
          return expect(viewModel.flowRate()).toEqual(783046.156);
        });
        return it('when second is chosen', function() {
          viewModel.selectedFlowRateUnit(OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits.second);
          return expect(viewModel.flowRate()).toEqual(9.064);
        });
      });
    });
  });

}).call(this);
