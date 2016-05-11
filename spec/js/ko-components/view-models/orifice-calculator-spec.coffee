describe 'orifice-calculator-viewmodel-spec', ->
  viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

  beforeEach ->
    viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

  itBehavesLikeMandatoryField = (field) ->
    it 'has mandatory field validation', ->
      field ''
      expect(field.isValid()).toEqual false

  itBehavesLikeIntegerField = (field) ->
    it 'should only accept integer', ->
      field 123
      expect(field.isValid()).toEqual true

      field 123.456
      expect(field.isValid()).toEqual false

      field '123abc'
      expect(field.isValid()).toEqual false

  itBehavesLikeFloatField = (field) ->
    it 'should only accept float', ->
      field 123
      expect(field.isValid()).toEqual true

      field 123.456
      expect(field.isValid()).toEqual true

      field '123abc'
      expect(field.isValid()).toEqual false

  describe 'viewModel', ->
    it 'should be invalid when it does not contain valid fields', ->
      viewModel.operatingPressure('abc123')
      expect(ko.validatedObservable(viewModel).isValid()).toEqual false

  describe 'availablePipes', ->
    it 'should have initialized the input data', ->
      expect(viewModel.availablePipes().length).toEqual 6

    it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
      expect(viewModel.selectedPipeDiameter()).toEqual OPL.OrificeCalculator.Config.Dictionaries.PipeId.oneNineInch.value

  describe 'operatingPressure', ->
    itBehavesLikeMandatoryField viewModel.operatingPressure
    itBehavesLikeIntegerField viewModel.operatingPressure

    describe 'when pressure is high', ->

      it 'should display a operatingPressureWarning message at > 200', ->
        viewModel.operatingPressure 201
        expect(viewModel.operatingPressureWarningMessage()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult

      it 'should display a operatingPressureWarning message at < 401', ->
        viewModel.operatingPressure 400
        expect(viewModel.operatingPressureWarningMessage()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult

      it 'should display an operatingPressureError message at > 400', ->
        viewModel.operatingPressure 401
        expect(viewModel.operatingPressureWarningMessage()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningWillResult

    describe 'when pressure is low', ->
      it 'should not have any messages', ->
        viewModel.operatingPressure 100
        expect(viewModel.operatingPressureWarningMessage()).toEqual undefined

  describe 'operatingPressureRead', ->
    it 'should have "Gauge" and "Absolute"', ->
      expect(viewModel.operatingPressureRead()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead

    it 'should have default value of "Gauge"', ->
      expect(viewModel.chosenOperatingPressureRead()).toEqual OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

  describe 'baseSpecificGravity', ->
    itBehavesLikeMandatoryField viewModel.baseSpecificGravity
    itBehavesLikeFloatField viewModel.baseSpecificGravity

  describe 'operatingTemperature', ->
    itBehavesLikeMandatoryField viewModel.operatingTemperature
    itBehavesLikeFloatField viewModel.operatingTemperature

  describe 'operatingTemperatureUnits', ->
    it 'should have default value of "Fahrenheit"', ->
      expect(viewModel.selectedOperatingTemperatureUnit()).toEqual OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    it 'should have Fahrenheit and Celsius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits

  describe 'differentialPressure', ->
    itBehavesLikeMandatoryField viewModel.differentialPressure
    itBehavesLikeIntegerField viewModel.differentialPressure

  describe 'orificeBoreDiameter', ->
    itBehavesLikeMandatoryField viewModel.orificeBoreDiameter
    itBehavesLikeFloatField viewModel.orificeBoreDiameter

  describe 'compressibilityCorrection', ->
    it 'should have a default value of "None"', ->
      expect(viewModel.chosenCompressibilityCorrection()).toEqual OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection

  describe 'displayCompressibilityCorrection', ->
    describe 'when compressibilityCorrection is none', ->
      it 'is false', ->
        viewModel.chosenCompressibilityCorrection OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
        expect(viewModel.displayCompressibilityCorrection()).toEqual false

    describe 'when compressibilityCorrection is not none', ->
      it 'is true', ->
        viewModel.chosenCompressibilityCorrection OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.zf
        expect(viewModel.displayCompressibilityCorrection()).toEqual true

  describe 'betaRatio', ->
    it 'should return beta ratio', ->
      viewModel.selectedPipeDiameter OPL.OrificeCalculator.Config.Dictionaries.PipeId.twoZeroInch.value
      viewModel.orificeBoreDiameter 0.97
      expect(viewModel.betaRatio()).toEqual 0.47

  describe 'velocityOfApproach', ->
    it 'should return velocity of approach', ->
      viewModel.orificeBoreDiameter 0.97
      viewModel.selectedPipeDiameter OPL.OrificeCalculator.Config.Dictionaries.PipeId.oneNineInch.value
      expect(viewModel.velocityOfApproach()).toEqual 1.04
      viewModel.orificeBoreDiameter 0.776
      viewModel.selectedPipeDiameter OPL.OrificeCalculator.Config.Dictionaries.PipeId.oneNineInch.value
      expect(viewModel.velocityOfApproach()).toEqual 1.02

  describe 'flowRate', ->
    it 'should return the flow rate', ->
      viewModel.orificeBoreDiameter 0.97
      viewModel.selectedPipeDiameter OPL.OrificeCalculator.Config.Dictionaries.PipeId.oneNineInch.value
      viewModel.operatingPressure 900
      viewModel.compressibilityCorrectionValue 1
      viewModel.differentialPressure 30
      viewModel.baseSpecificGravity 1
      viewModel.operatingTemperature 60
      expect(viewModel.flowRate()).toEqual 543.783

      viewModel.orificeBoreDiameter 0.776
      viewModel.selectedPipeDiameter OPL.OrificeCalculator.Config.Dictionaries.PipeId.oneNineInch.value
      viewModel.operatingPressure 900
      viewModel.compressibilityCorrectionValue 1
      viewModel.differentialPressure 30
      viewModel.baseSpecificGravity 1
      viewModel.operatingTemperature 60
      expect(viewModel.flowRate()).toEqual 341.328

