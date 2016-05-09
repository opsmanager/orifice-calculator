describe 'orifice-calculator-viewmodel-spec', ->
  viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

  beforeEach ->
    viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

  itBehavesLikeMandatoryField = (field) ->
    it 'has mandatory field validation', ->
      field('')
      expect(field.isValid()).toBeFalsy()

  itBehavesLikeIntegerField = (field) ->
    it 'should only accept integer', ->
      field(123)
      expect(field.isValid()).toBeTruthy()
      field(123.456)
      expect(field.isValid()).toBeFalsy()
      field('123abc')
      expect(field.isValid()).toBeFalsy()

  itBehavesLikeFloatField = (field) ->
    it 'should only accept float', ->
      field(123)
      expect(field.isValid()).toBeTruthy()
      field(123.456)
      expect(field.isValid()).toBeTruthy()
      field('123abc')
      expect(field.isValid()).toBeFalsy()

  describe 'viewModel', ->
    it 'should be valid when loaded', ->
      expect(ko.validatedObservable(viewModel).isValid()).toBeTruthy()
    it 'should be invalid when it does not contain valid fields', ->
      viewModel.operatingPressure('abc123')
      expect(ko.validatedObservable(viewModel).isValid()).toBeFalsy()

  describe 'pipeID', ->
    it 'should have initialized the input data', ->
      expect(viewModel.pipeID().length).toEqual 6

    it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
      expect(viewModel.selectedPipeID()).toEqual '1.939\'\' XS, Sch 80, Sch 80S'

  describe 'operatingPressure', ->
    itBehavesLikeMandatoryField viewModel.operatingPressure
    itBehavesLikeIntegerField viewModel.operatingPressure

  describe 'operatingPressureRead', ->
    it 'should have "Gauge" and "Absolute"', ->
      expect(viewModel.operatingPressureRead()).toEqual ['Gauge','Absolute']

    it 'should have default value of "Gauge"', ->
      expect(viewModel.chosenOperatingPressureRead()).toEqual 'Gauge'

  describe 'baseSpecificGravity', ->
    itBehavesLikeMandatoryField viewModel.baseSpecificGravity
    itBehavesLikeFloatField viewModel.baseSpecificGravity

    it 'should have a default value of "0.0"', ->
      expect(viewModel.baseSpecificGravity()).toEqual '0.0'

  describe 'operatingTemperature', ->
    itBehavesLikeMandatoryField viewModel.operatingTemperature
    itBehavesLikeFloatField viewModel.operatingTemperature

    it 'should have a default value of "0.0"', ->
      expect(viewModel.operatingTemperature()).toEqual '0.0'

  describe 'operatingTemperatureUnits', ->
    it 'should have default value of "Farenheit"', ->
      expect(viewModel.selectedOperatingTemperatureUnit()).toEqual 'F'

    it 'should have farenheit and celcius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit()).toEqual ['F','C']

  describe 'differentialPressure', ->
    itBehavesLikeMandatoryField viewModel.differentialPressure
    itBehavesLikeIntegerField viewModel.differentialPressure

    it 'should have a default value of "0"', ->
      expect(viewModel.differentialPressure()).toEqual 0

  describe 'orificeBoreDiameter', ->
    itBehavesLikeMandatoryField viewModel.orificeBoreDiameter
    itBehavesLikeFloatField viewModel.orificeBoreDiameter

    it 'should have a default value of "0.0"', ->
      expect(viewModel.orificeBoreDiameter()).toEqual '0.0'

  describe 'compressibilityCorrection', ->
    it 'should have a default value of "None"', ->
      expect(viewModel.chosenCompressibilityCorrection()).toEqual 'None'

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection()).toEqual [ 'None', 'Zf' ]
