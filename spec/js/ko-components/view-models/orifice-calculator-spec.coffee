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

    describe "availablePipes", ->
      it "should have initialized the input data", ->
        expect(viewModel.availablePipes().length).toEqual 6

      it "should have default value of '1.939\" XS, Sch 80, Sch 80S'", ->
        expect(viewModel.selectedPipeDiameter()).toEqual config.AvailablePipes.oneNineInch.value

    describe "availablePressureUnits", ->
      it "should have initialized the input data", ->
        expect(viewModel.availablePressureUnits().length).toEqual 10

      it "should have default value of 'inches water'", ->
        expect(viewModel.selectedDifferentialPressureUnit()).toEqual config.PressureUnits.inchesWater

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

    describe "flowRate", ->
      it "should return the flow rate", ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.minute
        expect(viewModel.flowRate()).toEqual 543.783

        viewModel.orificeBoreDiameter 0.776
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.minute
        expect(viewModel.flowRate()).toEqual 341.328

    describe "availableAvailableFlowRateUnits", ->
      it "should have initialized the input data", ->
        expect(viewModel.availableFlowRateUnits().length).toEqual 4

      it "should have default value of 'Minutes'", ->
        expect(viewModel.selectedFlowRateUnit()).toEqual config.AvailableFlowRateUnits.minute

    describe "selectedFlowRateUnit", ->
      beforeEach ->
        viewModel.orificeBoreDiameter 0.97
        viewModel.selectedPipeDiameter config.AvailablePipes.oneNineInch.value
        viewModel.operatingPressure 900
        viewModel.compressibilityCorrectionValue 1
        viewModel.differentialPressure 30
        viewModel.baseSpecificGravity 1
        viewModel.operatingTemperature 60

      it "when minute is chosen", ->
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.minute
        expect(viewModel.flowRate()).toEqual 543.783

      it "when hour is chosen", ->
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.hour
        expect(viewModel.flowRate()).toEqual 32626.924

      it "when day is chosen", ->
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.day
        expect(viewModel.flowRate()).toEqual 783046.156

      it "when second is chosen", ->
        viewModel.selectedFlowRateUnit config.AvailableFlowRateUnits.second
        expect(viewModel.flowRate()).toEqual 9.064
