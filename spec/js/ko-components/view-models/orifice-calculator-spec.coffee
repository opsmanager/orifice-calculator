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
    it 'should be valid when loaded', ->
      expect(ko.validatedObservable(viewModel).isValid()).toEqual true

    it 'should be invalid when it does not contain valid fields', ->
      viewModel.operatingPressure('abc123')
      expect(ko.validatedObservable(viewModel).isValid()).toEqual false

  describe 'pipeID', ->
    it 'should have initialized the input data', ->
      expect(viewModel.pipeID().length).toEqual 6

    it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
      expect(viewModel.selectedPipeID()).toEqual OPL.OrificeCalculator.Config.Dictionaries.PipeID.one_nine_inch

  describe 'operatingPressure', ->
    itBehavesLikeMandatoryField viewModel.operatingPressure
    itBehavesLikeIntegerField viewModel.operatingPressure

    describe 'when pressure is high', ->
      it 'should be invalid at > 200', ->
        viewModel.operatingPressure(300)
        expect(viewModel.operatingPressure.isValid()).toEqual false
        viewModel.operatingPressure(1000)
        expect(viewModel.operatingPressure.isValid()).toEqual false

      it 'should display a warning message at > 200', ->
        viewModel.operatingPressure(201)
        expect(viewModel.operatingPressure.error()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.warning

      it 'should display a warning message at < 401', ->
        viewModel.operatingPressure(400)
        expect(viewModel.operatingPressure.error()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.warning

      it 'should display an error message at > 400', ->
        viewModel.operatingPressure(401)
        expect(viewModel.operatingPressure.error()).toEqual OPL.OrificeCalculator.Config.Dictionaries.Messages.error

    describe 'when pressure is low', ->
      it 'should not have any messages', ->
        viewModel.operatingPressure(100)
        expect(viewModel.operatingPressure.isValid()).toEqual true

  describe 'operatingPressureRead', ->
    it 'should have "Gauge" and "Absolute"', ->
      expect(viewModel.operatingPressureRead()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead

    it 'should have default value of "Gauge"', ->
      expect(viewModel.chosenOperatingPressureRead()).toEqual OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

  describe 'baseSpecificGravity', ->
    itBehavesLikeMandatoryField viewModel.baseSpecificGravity
    itBehavesLikeFloatField viewModel.baseSpecificGravity

    it 'should have a default value of "0"', ->
      expect(viewModel.baseSpecificGravity()).toEqual 0

  describe 'operatingTemperature', ->
    itBehavesLikeMandatoryField viewModel.operatingTemperature
    itBehavesLikeFloatField viewModel.operatingTemperature

    it 'should have a default value of "0"', ->
      expect(viewModel.operatingTemperature()).toEqual 0

  describe 'operatingTemperatureUnits', ->
    it 'should have default value of "Fahrenheit"', ->
      expect(viewModel.selectedOperatingTemperatureUnit()).toEqual OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    it 'should have Fahrenheit and Celsius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits

  describe 'differentialPressure', ->
    itBehavesLikeMandatoryField viewModel.differentialPressure
    itBehavesLikeIntegerField viewModel.differentialPressure

    it 'should have a default value of "0"', ->
      expect(viewModel.differentialPressure()).toEqual 0

  describe 'orificeBoreDiameter', ->
    itBehavesLikeMandatoryField viewModel.orificeBoreDiameter
    itBehavesLikeFloatField viewModel.orificeBoreDiameter

    it 'should have a default value of "0"', ->
      expect(viewModel.orificeBoreDiameter()).toEqual 0

  describe 'compressibilityCorrection', ->
    it 'should have a default value of "None"', ->
      expect(viewModel.chosenCompressibilityCorrection()).toEqual OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection()).toEqual _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
