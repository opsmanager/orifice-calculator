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
      describe("initialize", function() {
        it("should have default value of 'Hour'", function() {
          return expect(viewModel.selectedFlowRateUnit()).toEqual(config.FlowRateTimeUnits.hour);
        });
        return it("should have default value of 'standard cubic feet'", function() {
          return expect(viewModel.selectedFlowUnit()).toEqual(config.FlowRatePressureUnits.standardCubicFeet);
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
      describe("calculatedDifferentialPressure", function() {
        it("should return the correct differential pressure", function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.flowRate(543.78);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          expect(viewModel.calculatedDifferentialPressure()).toEqual(30);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.flowRate(341.325);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(30);
        });
        it("when kgcm2 is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("kgcm2");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(0.077);
        });
        it("when kpa is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("kpa");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(7.466);
        });
        it("when pa is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("pa");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(7465.071);
        });
        it("when bar is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("bar");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(0.075);
        });
        it("when mbar is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("mbar");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(74.651);
        });
        it("when mmhg is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("mmhg");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(55.993);
        });
        it("when inhg is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("inhg");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(2.205);
        });
        it("when mmh2o is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("mmh2o");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(761.988);
        });
        return it("when psi is chosen", function() {
          viewModel.selectedDifferentialPressureUnit("psi");
          return expect(viewModel.calculatedDifferentialPressure()).toEqual(1.084);
        });
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
      describe("selectedCalculationField", function() {
        return describe("when there is changes in this field", function() {
          return it("will clear the value of flowRate and differentialPressure", function() {
            viewModel.selectedCalculationField("abc");
            expect(viewModel.flowRate()).toEqual(null);
            return expect(viewModel.differentialPressure()).toEqual(null);
          });
        });
      });
      describe("isCalculateDifferentialPressure", function() {
        describe("when the selectedCalculationField is 'differential pressure'", function() {
          return it("will return true", function() {
            viewModel.selectedCalculationField("differential pressure");
            return expect(viewModel.isCalculateDifferentialPressure()).toEqual(true);
          });
        });
        return describe("when the selectedCalculationField is not 'differential pressure'", function() {
          return it("will return false", function() {
            viewModel.selectedCalculationField("something else");
            return expect(viewModel.isCalculateDifferentialPressure()).toEqual(false);
          });
        });
      });
      describe("isCalculateFlowRate", function() {
        describe("when the selectedCalculationField is 'flow rate'", function() {
          return it("will return true", function() {
            viewModel.selectedCalculationField("flow rate");
            return expect(viewModel.isCalculateFlowRate()).toEqual(true);
          });
        });
        return describe("when the selectedCalculationField is not 'flow rate pressure'", function() {
          return it("will return false", function() {
            viewModel.selectedCalculationField("something else");
            return expect(viewModel.isCalculateFlowRate()).toEqual(false);
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
        return it("should have initialized the input data", function() {
          return expect(viewModel.availableFlowRateUnits().length).toEqual(4);
        });
      });
      describe("calculatedFlowRate", function() {
        return it("should return the flow rate", function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          viewModel.selectedDifferentialPressureUnit("inh2o");
          expect(viewModel.calculatedFlowRate()).toEqual(543.783);
          viewModel.orificeBoreDiameter(0.776);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.compressibilityCorrectionValue(1);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          viewModel.selectedDifferentialPressureUnit("inh2o");
          return expect(viewModel.calculatedFlowRate()).toEqual(341.328);
        });
      });
      describe("flowRateInStandardCubicFeetPerHour", function() {
        beforeEach(function() {
          return viewModel.flowRate(1250);
        });
        return it("should return the value according to the value selected", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicFeet);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.hour);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(1250);
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.pounds);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(16339.999999999998);
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.kilograms);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(36035);
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicMeters);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(44143.75);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(2648625);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.second);
          expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(158917500);
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.day);
          return expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual(1839.3229166666665);
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
          viewModel.operatingTemperature(60);
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicFeet);
          return viewModel.selectedDifferentialPressureUnit("inh2o");
        });
        it("when minute is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.minute);
          return expect(viewModel.calculatedFlowRate()).toEqual(543.783);
        });
        it("when hour is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.hour);
          return expect(viewModel.calculatedFlowRate()).toEqual(32626.924);
        });
        it("when day is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.day);
          return expect(viewModel.calculatedFlowRate()).toEqual(783046.156);
        });
        return it("when second is chosen", function() {
          viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.second);
          return expect(viewModel.calculatedFlowRate()).toEqual(9.064);
        });
      });
      describe("availableFlowUnits", function() {
        return it("should have the flow units", function() {
          return expect(viewModel.availableFlowUnits()).toEqual(_.values(config.FlowRatePressureUnits));
        });
      });
      describe("selectedFlowUnit", function() {
        beforeEach(function() {
          viewModel.orificeBoreDiameter(0.97);
          viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
          viewModel.operatingPressure(900);
          viewModel.differentialPressure(30);
          viewModel.baseSpecificGravity(1);
          viewModel.operatingTemperature(60);
          return viewModel.selectedFlowRateUnit(config.FlowRateTimeUnits.hour);
        });
        it("when standardCubicFeet is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicFeet);
          return expect(viewModel.calculatedFlowRate()).toEqual(32626.924);
        });
        it("when pounds is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.pounds);
          return expect(viewModel.calculatedFlowRate()).toEqual(2495.96);
        });
        it("when kilograms is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.kilograms);
          return expect(viewModel.calculatedFlowRate()).toEqual(1132.155);
        });
        return it("when standardCubicMeters is chosen", function() {
          viewModel.selectedFlowUnit(config.FlowRatePressureUnits.standardCubicMeters);
          return expect(viewModel.calculatedFlowRate()).toEqual(923.342);
        });
      });
      return describe("cookies", function() {
        describe("calculatedFlowRate", function() {
          beforeEach(function() {
            viewModel.selectedCalculationField("flow rate");
            viewModel.orificeBoreDiameter(1.02);
            viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
            viewModel.operatingPressure(600);
            viewModel.differentialPressure(20);
            viewModel.baseSpecificGravity(2);
            return viewModel.operatingTemperature(50);
          });
          return it("should set the values of each cookies", function() {
            expect(viewModel.orificeBoreDiameterCookies()).toContain({
              value: 1.02
            });
            expect(viewModel.operatingPressureCookies()).toContain({
              value: 600
            });
            expect(viewModel.differentialPressureCookies()).toContain({
              value: 20
            });
            expect(viewModel.baseSpecificGravityCookies()).toContain({
              value: 2
            });
            return expect(viewModel.operatingTemperatureCookies()).toContain({
              value: 50
            });
          });
        });
        describe("calculatedDifferentialPressure", function() {
          beforeEach(function() {
            viewModel.selectedCalculationField("differential pressure");
            viewModel.orificeBoreDiameter(1.02);
            viewModel.selectedPipeDiameter(config.AvailablePipes.oneNineInch.value);
            viewModel.operatingPressure(600);
            viewModel.baseSpecificGravity(2);
            viewModel.operatingTemperature(50);
            return viewModel.flowRate(543.783);
          });
          return it("should set the values of each cookies", function() {
            expect(viewModel.orificeBoreDiameterCookies()).toContain({
              value: 1.02
            });
            expect(viewModel.operatingPressureCookies()).toContain({
              value: 600
            });
            expect(viewModel.differentialPressureCookies()).toContain({
              value: 20
            });
            expect(viewModel.baseSpecificGravityCookies()).toContain({
              value: 2
            });
            expect(viewModel.operatingTemperatureCookies()).toContain({
              value: 50
            });
            return expect(viewModel.flowRateCookies()).toContain({
              value: 543.783
            });
          });
        });
        describe("initializeFieldsWithCookies", function() {
          beforeEach(function() {
            _.each(viewModel.FIELDS_FOR_SUGGESTION, function(field) {
              return Cookies.set(field, [102, 202]);
            });
            return viewModel.initializeFieldsWithCookies();
          });
          return it("initialize with the correct value", function() {
            return _.each(viewModel.FIELDS_FOR_SUGGESTION, function(field) {
              return expect(viewModel[field + "Cookies"]()).toEqual([
                {
                  value: 102
                }, {
                  value: 202
                }
              ]);
            });
          });
        });
        describe("setCookiesForFields", function() {
          beforeEach(function() {
            return spyOn(viewModel, "setCookies");
          });
          describe("if there is valid calculatedValue", function() {
            beforeEach(function() {
              return viewModel.setCookiesForFields(123, "differentialPressure");
            });
            return it("will call setCookies for every fields", function() {
              return expect(viewModel.setCookies).toHaveBeenCalled();
            });
          });
          return describe("if there is no valid calculatedValue", function() {
            beforeEach(function() {
              return viewModel.setCookiesForFields(void 0, "differentialPressure");
            });
            return it("will call setCookies for every fields", function() {
              return expect(viewModel.setCookies).not.toHaveBeenCalled();
            });
          });
        });
        return describe("getCookies", function() {
          describe("if there is valid cookies value", function() {
            beforeEach(function() {
              return Cookies.set("testCookies", [1, 2]);
            });
            return it("will return the value as an array", function() {
              return expect(viewModel.getCookies("testCookies")).toEqual([1, 2]);
            });
          });
          return describe("if there is no valid cookies value", function() {
            return it("will return an empty array", function() {
              return expect(viewModel.getCookies("testCookies2")).toEqual([]);
            });
          });
        });
      });
    });
  });

}).call(this);
