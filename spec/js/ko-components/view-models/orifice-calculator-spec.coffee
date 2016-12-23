define "orifice-calculator-viewmodel-spec", ["knockout", "jasmine-boot", "orifice-calculator-viewmodel"],  (ko) ->
  describe "orifice-calculator-viewmodel-spec", ->
    config = OPL.OrificeCalculator.Config.Dictionaries
    viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

    itBehavesLikeMandatoryField = (field) ->
      it "has mandatory field validation", ->
        field ""
        expect(field.isValid()).toEqual false

    itBehavesLikeIntegerField = (field) ->
      it "should only accept integer", ->
        field 123
        expect(field.isValid()).toEqual true

        field 123.456
        expect(field.isValid()).toEqual false

        field "123abc"
        expect(field.isValid()).toEqual false

    itBehavesLikeFloatField = (field) ->
      it "should only accept float", ->
        field 123
        expect(field.isValid()).toEqual true

        field 123.456
        expect(field.isValid()).toEqual true

        field "123abc"
        expect(field.isValid()).toEqual false

    describe "viewModel", ->
      it "should be invalid when it does not contain valid fields", ->
        viewModel.operatingPressure("abc123")
        expect(ko.validatedObservable(viewModel).isValid()).toEqual false

    describe "initialize", ->
      it "should have default value of 'Hour'", ->
        expect(viewModel.selectedFlowRateUnit()).toEqual config.FlowRateTimeUnits.hour

      it "should have default value of 'standard cubic feet'", ->
        expect(viewModel.selectedFlowUnit()).toEqual config.FlowRatePressureUnits.standardCubicFeet

    describe "availablePipes", ->
      it "should have initialized the input data", ->
        expect(viewModel.availablePipes().length).toEqual 6

      it "should have default value of '1.939\" XS, Sch 80, Sch 80S'", ->
        expect(viewModel.selectedPipeDiameter()).toEqual config.AvailablePipes.oneNineInch.value

    describe "availablePressureUnits", ->
      it "should have initialized the input data", ->
        expect(viewModel.availablePressureUnits().length).toEqual 10

      it "should have default value of 'inches water'", ->
        expect(viewModel.selectedDifferentialPressureUnit()).toEqual "inh2o"

    describe "availableBoreDiameterUnits", ->
      it "should have initialized the input data", ->
        expect(viewModel.availableBoreDiameterUnits().length).toEqual 3

      it "should have default value of 'inches'", ->
        expect(viewModel.selectedBoreDiameterUnit()).toEqual config.OrificeBoreDiameterUnits.inches

    describe "operatingPressure", ->
      itBehavesLikeMandatoryField viewModel.operatingPressure
      itBehavesLikeIntegerField viewModel.operatingPressure

      describe "when pressure is high", ->

        it "should display a operatingPressureWarning message at > 200", ->
          viewModel.operatingPressure 201
          expect(viewModel.operatingPressureWarningMessage()).toEqual config.Messages.operatingPressureWarningMayResult

        it "should display a operatingPressureWarning message at < 401", ->
          viewModel.operatingPressure 400
          expect(viewModel.operatingPressureWarningMessage()).toEqual config.Messages.operatingPressureWarningMayResult

        it "should display an operatingPressureError message at > 400", ->
          viewModel.operatingPressure 401
          expect(viewModel.operatingPressureWarningMessage()).toEqual config.Messages.operatingPressureWarningWillResult

      describe "when pressure is low", ->
        it "should not have any messages", ->
          viewModel.operatingPressure 100
          expect(viewModel.operatingPressureWarningMessage()).toEqual undefined

    describe "operatingPressureRead", ->
      it "should have 'Gauge' and 'Absolute'", ->
        expect(viewModel.operatingPressureRead()).toEqual _.values config.OperatingPressureRead

      it "should have default value of 'Gauge'", ->
        expect(viewModel.selectedOperatingPressureRead()).toEqual config.OperatingPressureRead.gauge

    describe "availableBaseSpecificGravity", ->
      it "should have the options in the dictionary", ->
        expect(viewModel.availableBaseSpecificGravity()).toEqual _.values config.BaseSpecificGravity

    describe "baseSpecificGravity", ->
      itBehavesLikeMandatoryField viewModel.baseSpecificGravity
      itBehavesLikeFloatField viewModel.baseSpecificGravity

    describe "operatingTemperature", ->
      itBehavesLikeMandatoryField viewModel.operatingTemperature
      itBehavesLikeFloatField viewModel.operatingTemperature

    describe "operatingTemperatureUnits", ->
      it "should have default value of 'Fahrenheit'", ->
        expect(viewModel.selectedOperatingTemperatureUnit()).toEqual config.OperatingTemperatureUnits.fahrenheit

      it "should have Fahrenheit and Celsius for operating temperature unit", ->
        expect(viewModel.operatingTemperatureUnit()).toEqual _.values config.OperatingTemperatureUnits

    describe "differentialPressure", ->
      itBehavesLikeMandatoryField viewModel.differentialPressure
      itBehavesLikeIntegerField viewModel.differentialPressure

    describe "calculatedDifferentialPressure", ->
      it "should return the correct differential pressure", ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.flowRate 543.78
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        expect(viewModel.calculatedDifferentialPressure()).toEqual 30

        viewModel.orificeBoreDiameter 0.776
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.flowRate 341.325
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        expect(viewModel.calculatedDifferentialPressure()).toEqual 30

      it "when kgcm2 is chosen", ->
        viewModel.selectedDifferentialPressureUnit "kgcm2"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 0.077

      it "when kpa is chosen", ->
        viewModel.selectedDifferentialPressureUnit "kpa"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 7.466

      it "when pa is chosen", ->
        viewModel.selectedDifferentialPressureUnit "pa"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 7465.071

      it "when bar is chosen", ->
        viewModel.selectedDifferentialPressureUnit "bar"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 0.075

      it "when mbar is chosen", ->
        viewModel.selectedDifferentialPressureUnit "mbar"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 74.651

      it "when mmhg is chosen", ->
        viewModel.selectedDifferentialPressureUnit "mmhg"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 55.993

      it "when inhg is chosen", ->
        viewModel.selectedDifferentialPressureUnit "inhg"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 2.205

      it "when mmh2o is chosen", ->
        viewModel.selectedDifferentialPressureUnit "mmh2o"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 761.988

      it "when psi is chosen", ->
        viewModel.selectedDifferentialPressureUnit "psi"
        expect(viewModel.calculatedDifferentialPressure()).toEqual 1.084

    describe "orificeBoreDiameter", ->
      itBehavesLikeMandatoryField viewModel.orificeBoreDiameter
      itBehavesLikeFloatField viewModel.orificeBoreDiameter

    describe "compressibilityCorrection", ->
      it "should have a default value of 'None'", ->
        expect(viewModel.selectedCompressibilityCorrection()).toEqual config.CompressibilityCorrection.none

      it "should have None and Zf for compressibility correction", ->
        expect(viewModel.compressibilityCorrection()).toEqual _.values config.CompressibilityCorrection

    describe "displayCompressibilityCorrection", ->
      describe "when compressibilityCorrection is none", ->
        it "is false", ->
          viewModel.selectedCompressibilityCorrection config.CompressibilityCorrection.none
          expect(viewModel.displayCompressibilityCorrection()).toEqual false

      describe "when compressibilityCorrection is not none", ->
        it "is true", ->
          viewModel.selectedCompressibilityCorrection config.CompressibilityCorrection.zf
          expect(viewModel.displayCompressibilityCorrection()).toEqual true

    describe "selectedCompressibilityCorrection", ->
      beforeEach ->
        viewModel.selectedCompressibilityCorrection config.CompressibilityCorrection.zf
        viewModel.compressibilityCorrectionValue 3
        viewModel.selectedCompressibilityCorrection config.CompressibilityCorrection.none

      describe "when displayCompressibilityCorrection is false", ->
        it "will displayed the compressibilityCorrectionValue's default value", ->
          expect(viewModel.compressibilityCorrectionValue()).toEqual 1

    describe "selectedCalculationField", ->
      describe "when there is changes in this field", ->
        it "will clear the value of flowRate and differentialPressure", ->
          viewModel.selectedCalculationField "abc"
          expect(viewModel.flowRate()).toEqual null
          expect(viewModel.differentialPressure()).toEqual null

    describe "isCalculateDifferentialPressure", ->
      describe "when the selectedCalculationField is 'differential pressure'", ->
        it "will return true", ->
          viewModel.selectedCalculationField "differential pressure"
          expect(viewModel.isCalculateDifferentialPressure()).toEqual true

      describe "when the selectedCalculationField is not 'differential pressure'", ->
        it "will return false", ->
          viewModel.selectedCalculationField "something else"
          expect(viewModel.isCalculateDifferentialPressure()).toEqual false

    describe "isCalculateFlowRate", ->
      describe "when the selectedCalculationField is 'flow rate'", ->
        it "will return true", ->
          viewModel.selectedCalculationField "flow rate"
          expect(viewModel.isCalculateFlowRate()).toEqual true

      describe "when the selectedCalculationField is not 'flow rate pressure'", ->
        it "will return false", ->
          viewModel.selectedCalculationField "something else"
          expect(viewModel.isCalculateFlowRate()).toEqual false

    describe "betaRatio", ->
      it "should return beta ratio", ->
        viewModel.selectedPipeDiameter config.AvailablePipes.twoZeroInch.value
        viewModel.orificeBoreDiameter 0.97
        expect(viewModel.betaRatio()).toEqual 0.46928

    describe "velocityOfApproach", ->
      it "should return velocity of approach", ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        expect(viewModel.velocityOfApproach()).toEqual 1.04
        viewModel.orificeBoreDiameter 0.776
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        expect(viewModel.velocityOfApproach()).toEqual 1.02

    describe "availableFlowRateUnits", ->
      it "should have initialized the input data", ->
        expect(viewModel.availableFlowRateUnits().length).toEqual 4

    describe "calculatedFlowRate", ->
      it "should return the flow rate", ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        viewModel.selectedDifferentialPressureUnit "inh2o"
        expect(viewModel.calculatedFlowRate()).toEqual 543.783

        viewModel.orificeBoreDiameter 0.776
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        viewModel.selectedDifferentialPressureUnit "inh2o"
        expect(viewModel.calculatedFlowRate()).toEqual 341.328

    describe "flowRateInStandardCubicFeetPerHour", ->
      beforeEach ->
        viewModel.flowRate 1250

      it "should return the value according to the value selected", ->
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.standardCubicFeet
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.hour
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 1250

        viewModel.selectedFlowUnit config.FlowRatePressureUnits.pounds
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 16339.999999999998
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.kilograms
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 36035
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.standardCubicMeters
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 44143.75

        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 2648625
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.second
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 158917500
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.day
        expect(viewModel.flowRateInStandardCubicFeetPerHour()).toEqual 1839.3229166666665

    describe "selectedFlowRateUnit", ->
      beforeEach ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.standardCubicFeet
        viewModel.selectedDifferentialPressureUnit "inh2o"

      it "when minute is chosen", ->
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.minute
        expect(viewModel.calculatedFlowRate()).toEqual 543.783

      it "when hour is chosen", ->
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.hour
        expect(viewModel.calculatedFlowRate()).toEqual 32626.924

      it "when day is chosen", ->
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.day
        expect(viewModel.calculatedFlowRate()).toEqual 783046.156

      it "when second is chosen", ->
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.second
        expect(viewModel.calculatedFlowRate()).toEqual 9.064

    describe "availableFlowUnits", ->
      it "should have the flow units", ->
        expect(viewModel.availableFlowUnits()).toEqual _.values config.FlowRatePressureUnits

    describe "selectedFlowUnit", ->
      beforeEach ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowRateUnit config.FlowRateTimeUnits.hour

      it "when standardCubicFeet is chosen", ->
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.standardCubicFeet
        expect(viewModel.calculatedFlowRate()).toEqual 32626.924 #32712

      it "when pounds is chosen", ->
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.pounds
        expect(viewModel.calculatedFlowRate()).toEqual 2495.96 #2497

      it "when kilograms is chosen", ->
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.kilograms
        expect(viewModel.calculatedFlowRate()).toEqual 1132.155 #1133

      it "when standardCubicMeters is chosen", ->
        viewModel.selectedFlowUnit config.FlowRatePressureUnits.standardCubicMeters
        expect(viewModel.calculatedFlowRate()).toEqual 923.342 #926.3

    describe "cookies", ->
      describe "calculatedFlowRate", ->
        beforeEach ->
          viewModel.selectedCalculationField "flow rate"
          viewModel.orificeBoreDiameter 1.02
          viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
          viewModel.operatingPressure 600
          viewModel.differentialPressure 20
          viewModel.baseSpecificGravity 2
          viewModel.operatingTemperature 50

        it "should set the values of each cookies", ->
          expect(viewModel.orificeBoreDiameterCookies()).toContain  { value: 1.02 }
          expect(viewModel.operatingPressureCookies()).toContain    { value: 600 }
          expect(viewModel.differentialPressureCookies()).toContain { value: 20 }
          expect(viewModel.baseSpecificGravityCookies()).toContain  { value: 2 }
          expect(viewModel.operatingTemperatureCookies()).toContain { value: 50 }

      describe "calculatedDifferentialPressure", ->
        beforeEach ->
          viewModel.selectedCalculationField "differential pressure"
          viewModel.orificeBoreDiameter 1.02
          viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
          viewModel.operatingPressure 600
          viewModel.baseSpecificGravity 2
          viewModel.operatingTemperature 50
          viewModel.flowRate 543.783

        it "should set the values of each cookies", ->
          expect(viewModel.orificeBoreDiameterCookies()).toContain  { value: 1.02 }
          expect(viewModel.operatingPressureCookies()).toContain    { value: 600 }
          expect(viewModel.differentialPressureCookies()).toContain { value: 20 }
          expect(viewModel.baseSpecificGravityCookies()).toContain  { value: 2 }
          expect(viewModel.operatingTemperatureCookies()).toContain { value: 50 }
          expect(viewModel.flowRateCookies()).toContain             { value: 543.783 }

      describe "initializeFieldsWithCookies", ->
        beforeEach ->
          _.each viewModel.FIELDS_FOR_SUGGESTION, (field) ->
            Cookies.set(field, [102,202])

          viewModel.initializeFieldsWithCookies()

        it "initialize with the correct value", ->
          _.each viewModel.FIELDS_FOR_SUGGESTION, (field) ->
            expect(viewModel["#{field}Cookies"]()).toEqual [{ value: 102 }, { value: 202 } ]

      describe "setCookiesForFields", ->
        beforeEach ->
          spyOn(viewModel, "setCookies")

        describe "if there is valid calculatedValue", ->
          beforeEach ->
            viewModel.setCookiesForFields(123, "differentialPressure")

          it "will call setCookies for every fields", ->
            expect(viewModel.setCookies).toHaveBeenCalled()

        describe "if there is no valid calculatedValue", ->
          beforeEach ->
            viewModel.setCookiesForFields(undefined, "differentialPressure")

          it "will call setCookies for every fields", ->
            expect(viewModel.setCookies).not.toHaveBeenCalled()

      describe "getCookies", ->
        describe "if there is valid cookies value", ->
          beforeEach ->
            Cookies.set("testCookies", [1,2])

          it "will return the value as an array", ->
            expect(viewModel.getCookies("testCookies")).toEqual [1,2]

        describe "if there is no valid cookies value", ->
          it "will return an empty array", ->
            expect(viewModel.getCookies("testCookies2")).toEqual []
