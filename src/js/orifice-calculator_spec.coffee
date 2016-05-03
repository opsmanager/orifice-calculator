define(['js/orifice-calculator.js'], (orificeCalculator) ->
  describe 'OrificeCalculatorViewModel', ->
    viewModel = new orificeCalculator()
  
    it 'should have initialized the input data', ->     
      expect(viewModel.pipeID().length).toEqual 6
      expect(viewModel.operatingPressureRead.length).toEqual 2

    it 'should have farenheit and celcius for operating temperature unit', ->
      expect(viewModel.operatingTemperatureUnit).toEqual ['F','C']

    it 'should have None and Zf for compressibility correction', ->
      expect(viewModel.compressibilityCorrection).toEqual [ 'None', 'Zf' ]

    describe 'pipeID', ->
      it 'should have default value of 1.939\'\' XS, Sch 80, Sch 80S', ->
        expect(viewModel.selectedPipeID()).toEqual '1.939\'\' XS, Sch 80, Sch 80S' 
)
