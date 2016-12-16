(function() {
  define("orifice-calculator-viewmodel-spec", ["knockout", "jasmine-boot", "orifice-calculator-viewmodel"], function(ko) {
    return describe("orifice-calculator-viewmodel-spec", function() {
      var config, itBehavesLikeFloatField, itBehavesLikeIntegerField, itBehavesLikeMandatoryField, viewModel;
      config = OPL.OrificeCalculator.Config.Dictionaries;
      viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator();
      itBehavesLikeMandatoryField = function(field) {
        return it("has mandatory field validation", function() {
          field("");
          return expect(field.isValid()).toEqual(false);
        });
      };
      itBehavesLikeIntegerField = function(field) {
        return it("should only accept integer", function() {
          field(123);
          expect(field.isValid()).toEqual(true);
          field(123.456);
          expect(field.isValid()).toEqual(false);
          field("123abc");
          return expect(field.isValid()).toEqual(false);
        });
      };
      itBehavesLikeFloatField = function(field) {
        return it("should only accept float", function() {
          field(123);
          expect(field.isValid()).toEqual(true);
          field(123.456);
          expect(field.isValid()).toEqual(true);
          field("123abc");
          return expect(field.isValid()).toEqual(false);
        });
      };
      describe("viewModel", function() {
        return it("should be invalid when it does not contain valid fields", function() {
          viewModel.operatingPressure("abc123");
          return expect(ko.validatedObservable(viewModel).isValid()).toEqual(false);
        });
      });
      describe("availablePipes", function() {
        it("should have initialized the input data", function() {
          return expect(viewModel.availablePipes().length).toEqual(6);
        });
        return it("should have default value of '1.939\" XS, Sch 80, Sch 80S'", function() {
          return expect(viewModel.selectedPipeDiameter()).toEqual(config.AvailablePipes.oneNineInch.value);
        });
      });
      describe("availablePressureUnits", function() {
        it("should have initialized the input data", function() {
          return expect(viewModel.availablePressureUnits().length).toEqual(10);
        });
        return it("should have default value of 'inches water'", function() {
          return expect(viewModel.selectedDifferentialPressureUnit()).toEqual("inh2o");
        });
      });
      describe("availableBoreDiameterUnits", function() {
        it("should have initialized the input data", function() {
          return expect(viewModel.availableBoreDiameterUnits().length).toEqual(3);
        });
        return it("should have default value of 'inches'", function() {
          return expect(viewModel.selectedBoreDiameterUnit()).toEqual(config.OrificeBoreDiameterUnits.inches);
        });
      });
      describe("operatingPressure", function() {
        itBehavesLikeMandatoryField(viewModel.operatingPressure);
        itBehavesLikeIntegerField(viewModel.operatingPressure);
        describe("when pressure is high", function() {
          it("should display a operatingPressureWarning message at > 200", function() {
            viewModel.operatingPressure(201);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(config.Messages.operatingPressureWarningMayResult);
          });
          it("should display a operatingPressureWarning message at < 401", function() {
            viewModel.operatingPressure(400);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(config.Messages.operatingPressureWarningMayResult);
          });
          return it("should display an operatingPressureError message at > 400", function() {
            viewModel.operatingPressure(401);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(config.Messages.operatingPressureWarningWillResult);
          });
        });
        return describe("when pressure is low", function() {
          return it("should not have any messages", function() {
            viewModel.operatingPressure(100);
            return expect(viewModel.operatingPressureWarningMessage()).toEqual(void 0);
          });
        });
      });
      describe("operatingPressureRead", function() {
        it("should have 'Gauge' and 'Absolute'", function() {
          return expect(viewModel.operatingPressureRead()).toEqual(_.values(config.OperatingPressureRead));
        });
        return it("should have default value of 'Gauge'", function() {
          return expect(viewModel.selectedOperatingPressureRead()).toEqual(config.OperatingPressureRead.gauge);
        });
      });
      describe("availableBaseSpecificGravity", function() {
        return it("should have the options in the dictionary", function() {
          return expect(viewModel.availableBaseSpecificGravity()).toEqual(_.values(config.BaseSpecificGravity));
        });
      });
      describe("baseSpecificGravity", function() {
        itBehavesLikeMandatoryField(viewModel.baseSpecificGravity);
        return itBehavesLikeFloatField(viewModel.baseSpecificGravity);
      });
      describe("operatingTemperature", function() {
        itBehavesLikeMandatoryField(viewModel.operatingTemperature);
        return itBehavesLikeFloatField(viewModel.operatingTemperature);
      });
      describe("operatingTemperatureUnits", function() {
        it("should have default value of 'Fahrenheit'", function() {
          return expect(viewModel.selectedOperatingTemperatureUnit()).toEqual(config.OperatingTemperatureUnits.fahrenheit);
        });
        return it("should have Fahrenheit and Celsius for operating temperature unit", function() {
          return expect(viewModel.operatingTemperatureUnit()).toEqual(_.values(config.OperatingTemperatureUnits));
        });
      });
      describe("differentialPressure", function() {
        itBehavesLikeMandatoryField(viewModel.differentialPressure);
        return itBehavesLikeIntegerField(viewModel.differentialPressure);
      });
      describe("orificeBoreDiameter", function() {
        itBehavesLikeMandatoryField(viewModel.orificeBoreDiameter);
        return itBehavesLikeFloatField(viewModel.orificeBoreDiameter);
      });
      describe("compressibilityCorrection", function() {
        it("should have a default value of 'None'", function() {
          return expect(viewModel.selectedCompressibilityCorrection()).toEqual(config.CompressibilityCorrection.none);
        });
        return it("should have None and Zf for compressibility correction", function() {
          return expect(viewModel.compressibilityCorrection()).toEqual(_.values(config.CompressibilityCorrection));
        });
      });
      describe("displayCompressibilityCorrection", function() {
        describe("when compressibilityCorrection is none", function() {
          return it("is false", function() {
            viewModel.selectedCompressibilityCorrection(config.CompressibilityCorrection.none);
            return expect(viewModel.displayCompressibilityCorrection()).toEqual(false);
          });
        });
        return describe("when compressibilityCorrection is not none", function() {
          return it("is true", function() {
            viewModel.selectedCompressibilityCorrection(config.CompressibilityCorrection.zf);
            return expect(viewModel.displayCompressibilityCorrection()).toEqual(true);
          });
        });
      });
      describe("selectedCompressibilityCorrection", function() {
        beforeEach(function() {
          viewModel.selectedCompressibilityCorrection(config.CompressibilityCorrection.zf);
          viewModel.compressibilityCorrectionValue(3);
          return viewModel.selectedCompressibilityCorrection(config.CompressibilityCorrection.none);
        });
        return describe("when displayCompressibilityCorrection is false", function() {
          return it("will displayed the compressibilityCorrectionValue's default value", function() {
            return expect(viewModel.compressibilityCorrectionValue()).toEqual(1);
          });
        });
      });
      describe("betaRatio", function() {
        return it("should return beta ratio", function() {
          viewModel.selectedPipeDiameter(config.AvailablePipes.twoZeroInch.value);
          viewModel.orificeBoreDiameter(0.97);
          return expect(viewModel.betaRatio()).toEqual(0.46928);
        });
      });
      describe("velocityOfApproach", function() {
        return it("should return velocity of approach", function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          expect(viewModel.velocityOfApproach()).toEqual(1.04);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          return expect(viewModel.velocityOfApproach()).toEqual(1.02);
        });
      });
      describe("availableFlowRateUnits", function() {
        it("should have initialized the input data", function() {
          return expect(viewModel.availableFlowRateUnits().length).toEqual(4);
        });
        return it("should have default value of 'Hour'", function() {
          return expect(viewModel.selectedFlowRateUnit()).toEqual(config.FlowRateTimeUnits.hour);
        });
      });
      describe("flowRate", function() {
        return it("should return the flow rate", function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          expect(viewModel.flowRate()).toEqual(543.783);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          return expect(viewModel.flowRate()).toEqual(341.328);
        });
      });
      describe("selectedFlowRateUnit", function() {
        beforeEach(function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          return viewModel.operatingTemperature(60);
        });
        it("when minute is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          return expect(viewModel.flowRate()).toEqual(543.783);
        });
        it("when hour is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.hour);
          return expect(viewModel.flowRate()).toEqual(32626.924);
        });
        it("when day is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.day);
          return expect(viewModel.flowRate()).toEqual(783046.156);
        });
        return it("when second is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.second);
          return expect(viewModel.flowRate()).toEqual(9.064);
        });
      });
      describe("availableFlowUnits", function() {
        return it("should have the flow units", function() {
          return expect(viewModel.availableFlowUnits()).toEqual(_.values(config.FlowRatePressureUnits));
        });
      });
      return describe("selectedFlowUnit", function() {
        beforeEach(function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          return viewModel.operatingTemperature(60);
        });
        it("should have default value of 'standard cubic feet'", function() {
          return expect(viewModel.selectedFlowUnit()).toEqual(config.FlowRatePressureUnits.standardCubicFeet);
        });
        it("when standardCubicFeet is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicFeet);
          return expect(viewModel.flowRate()).toEqual(32626.924);
        });
        it("when pounds is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.pounds);
          return expect(viewModel.flowRate()).toEqual(2495.96);
        });
        it("when kilograms is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.kilograms);
          return expect(viewModel.flowRate()).toEqual(1131.768);
        });
        return it("when standardCubicMeters is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicMeters);
          return expect(viewModel.flowRate()).toEqual(923.892);
        });
      });
    });
  });

}).call(this);
