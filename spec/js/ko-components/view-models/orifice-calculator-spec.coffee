describe 'orifice-calculator-viewmodel-spec', ->
  viewModel = null
  field = ko.observable()

  beforeEach ->
    viewModel = new OPL.KoComponents.ViewModels.OrificeCalculator()

  itBehavesLikeMandatoryField = () ->
    it 'has mandatory field validation', ->
      field('')
      expect(field.isValid()).toEqual false

  itBehavesLikeIntegerField = () ->
    it 'should only accept integer', ->
      field(123)
      expect(field.isValid()).toEqual true
      field(123.456)
      expect(field.isValid()).toEqual false
      field('123abc')
      expect(field.isValid()).toEqual false

  itBehavesLikeFloatField = () ->
    it 'should only accept float', ->
      field(123)
      expect(field.isValid()).toEqual true
      field(123.456)
      expect(field.isValid()).toEqual true
      field('123abc')
      expect(field.isValid()).toEqual false

  describe 'pipeID', ->
    it 'should have initialized the input data', ->
      expect(viewModel.pipeID().length).toEqual 6

    it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
      expect(viewModel.selectedPipeID()).toEqual '1.939\'\' XS, Sch 80, Sch 80S'

  describe 'operatingPressure', ->
    beforeEach ->
      field = viewModel.operatingPressure

    itBehavesLikeMandatoryField()
    itBehavesLikeIntegerField()

  describe 'operatingPressureRead', ->
    it 'should have "Gauge" and "Absolute"', ->
        expect(viewModel.operatingPressureRead()).toEqual ['Gauge','Absolute']

    it 'should have default value of "Gauge"', ->
      expect(viewModel.chosenOperatingPressureRead()).toEqual 'Gauge'

  describe 'baseSpecificGravity', ->
    beforeEach ->
      field = viewModel.baseSpecificGravity
      validationMessage = 'Please enter the base specific gravity'

    itBehavesLikeMandatoryField()
    itBehavesLikeFloatField()

    it 'should have a default value of "0.0"', ->
      expect(viewModel.baseSpecificGravity()).toEqual '0.0'

  describe 'operatingTemperature', ->
    beforeEach ->
      field = viewModel.operatingTemperature
      validationMessage = 'Please enter the operating temperature'

    itBehavesLikeMandatoryField()
    itBehavesLikeFloatField()

    it 'should have a default value of "0.0"', ->
      expect(viewModel.operatingTemperature()).toEqual '0.0'

  describe 'operatingTemperatureUnits', ->
    it 'should have default value of "Farenheit"', ->
      expect(viewModel.selectedOperatingTemperatureUnit()).toEqual 'F'

    it 'should have farenheit and celcius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit()).toEqual ['F','C']

  describe 'differentialPressure', ->
    beforeEach ->
      field = viewModel.differentialPressure
      validationMessage = 'Please enter the differential pressure'

    itBehavesLikeMandatoryField()
    itBehavesLikeIntegerField()

    it 'should have a default value of "0"', ->
      expect(viewModel.differentialPressure()).toEqual 0

  describe 'orificeBoreDiameter', ->
    beforeEach ->
      field = viewModel.orificeBoreDiameter
      validationMessage = 'Please enter the orifice bore diameter'

    itBehavesLikeMandatoryField()
    itBehavesLikeFloatField()

    it 'should have a default value of "0.0"', ->
      expect(viewModel.orificeBoreDiameter()).toEqual '0.0'

  describe 'compressibilityCorrection', ->
    it 'should have a default value of "None"', ->
      expect(viewModel.chosenCompressibilityCorrection()).toEqual 'None'

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection()).toEqual [ 'None', 'Zf' ]
