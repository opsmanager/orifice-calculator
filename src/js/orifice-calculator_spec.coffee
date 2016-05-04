define(['js/orifice-calculator.js'], (orificeCalculator) ->
  describe 'OrificeCalculatorViewModel', ->
    viewModel = new orificeCalculator()

    itBehavesLikeMandatoryField = (observable, validationMessage = '') ->
      it 'has mandatory field validation', ->
        observable('')
        expect(observable.hasError()).toEqual true
        expect(observable.validationMessage()).toEqual validationMessage
        
    describe 'pipeID', ->
      it 'should have initialized the input data', ->     
        expect(viewModel.pipeID().length).toEqual 6

      it 'should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', ->
        expect(viewModel.selectedPipeID()).toEqual '1.939\'\' XS, Sch 80, Sch 80S'

    describe 'operatingPressure', ->
      it 'should have a default value of "0"', ->
        expect(viewModel.operatingPressure()).toEqual '0'

      itBehavesLikeMandatoryField(viewModel.operatingPressure, 'Please enter the operating pressure')

      describe 'when pressure is high', ->
        it 'should display a warning message', ->
          viewModel.operatingPressure('300')
          expect(viewModel.operatingPressure.showMessage()).toEqual true
          expect(viewModel.operatingPressure.statusMessage()).toEqual 'At this pressure, no compressibility correction may result in erroneous computations'
          expect(viewModel.operatingPressure.status()).toEqual 'warning'

        it 'should display an error message', ->
          viewModel.operatingPressure('1000')
          expect(viewModel.operatingPressure.showMessage()).toEqual true
          expect(viewModel.operatingPressure.statusMessage()).toEqual 'At this pressure, no compressibility correction will result in erroneous computations'
          expect(viewModel.operatingPressure.status()).toEqual 'error'

      describe 'when pressure is low', ->
        it 'should not have any messages', ->
          viewModel.operatingPressure('100')
          expect(viewModel.operatingPressure.showMessage()).toEqual false

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

    describe 'baseSpecificGravity', ->
      it 'should have a default value of "0.0"', ->
        expect(viewModel.baseSpecificGravity()).toEqual '0.0'
        
      itBehavesLikeMandatoryField(viewModel.baseSpecificGravity, 'Please enter the base specific gravity')
      
    describe 'operatingTemperature', ->
      it 'should have a default value of "0"', ->
        expect(viewModel.operatingTemperature()).toEqual '0'
        
      itBehavesLikeMandatoryField(viewModel.operatingTemperature, 'Please enter the operating temperature')

    describe 'operatingTemperatureUnits', ->
      it 'should have default value of "Farenheit"', ->
        expect(viewModel.selectedOperatingTemperatureUnit()).toEqual 'F'
        
      it 'should have farenheit and celcius for operating temperature unit', ->
        expect(viewModel.operatingTemperatureUnit()).toEqual ['F','C']

    describe 'differentialPressure', ->
      it 'should have a default value of "0"', ->
        expect(viewModel.differentialPressure()).toEqual '0'
        
      itBehavesLikeMandatoryField(viewModel.differentialPressure, 'Please enter the differential pressure')

    describe 'orificeBoreDiameter', ->
      it 'should have a default value of "0.0"', ->
        expect(viewModel.orificeBoreDiameter()).toEqual '0.0'
        
      itBehavesLikeMandatoryField(viewModel.orificeBoreDiameter, 'Please enter the orifice bore diameter')
    describe 'compressibilityCorrection', ->
      it 'should have a default value of "None"', ->
        expect(viewModel.chosenCompressibilityCorrection()).toEqual 'None' 
        
      it 'should have None and Zf for compressibility correction', ->
        expect(viewModel.compressibilityCorrection()).toEqual [ 'None', 'Zf' ]
    
)
