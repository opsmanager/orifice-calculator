describe 'OrificeCalculatorViewModel', ->
  viewModel = new OrificeCalculator()

  describe 'pipeID', ->
    it 'should have initialized the input data', ->
      expect(viewModel.pipeID().length).toEqual 6

    it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
      expect(viewModel.selectedPipeID()).toEqual '1.939\'\' XS, Sch 80, Sch 80S'

  describe 'operatingPressureRead', ->
    it 'should have "Gauge" and "Absolute"', ->
        expect(viewModel.operatingPressureRead()).toEqual ['Gauge','Absolute']

    it 'should have default value of "Gauge"', ->
      expect(viewModel.chosenOperatingPressureRead()).toEqual 'Gauge'

  describe 'operatingPressureUnits', ->
    it 'should have intialized the input data', ->
      expect(viewModel.operatingPressureUnits().length).toEqual 8

    it 'should have default value of "PSI"', ->
      expect(viewModel.selectedOperatingPressureUnits()).toEqual 'PSI'

  describe 'operatingTemperatureUnits', ->
    it 'should have default value of "Farenheit"', ->
      expect(viewModel.selectedOperatingTemperatureUnit()).toEqual 'F'

    it 'should have farenheit and celcius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit()).toEqual ['F','C']

  describe 'compressibilityCorrection', ->
    it 'should have a default value of "None"', ->
      expect(viewModel.chosenCompressibilityCorrection()).toEqual 'None'

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection()).toEqual [ 'None', 'Zf' ]
