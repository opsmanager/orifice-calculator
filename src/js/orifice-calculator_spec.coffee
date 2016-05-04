define(['js/orifice-calculator.js'], (orificeCalculator) ->
  describe 'OrificeCalculatorViewModel', ->
    viewModel = null
    field = ko.observable()
    validationMessage = ''
    
    beforeEach ->
      viewModel = new orificeCalculator()

    itBehavesLikeMandatoryField = () ->
      it 'has mandatory field validation', ->
        field('')
        expect(field.hasError()).toEqual true
        expect(field.validationMessage()).toEqual validationMessage

    describe 'pipeID', ->
        
      it 'should have initialized the input data', ->
        expect(viewModel.pipeID().length).toEqual 6

      it 'should have default value of "1.939"', ->
        expect(viewModel.selectedPipeID().name).toEqual '1.939\'\' XS, Sch 80, Sch 80S'
        expect(viewModel.selectedPipeID().value).toEqual '1.939'

    describe 'operatingPressure', ->
      beforeEach ->
        field = viewModel.operatingPressure
        validationMessage = 'Please enter the operating pressure'

      itBehavesLikeMandatoryField()

      it 'should have a default value of "0"', ->
        expect(viewModel.operatingPressure()).toEqual '0'

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
      beforeEach ->
        field = viewModel.baseSpecificGravity
        validationMessage = 'Please enter the base specific gravity'

      itBehavesLikeMandatoryField()

      it 'should have a default value of "0.0"', ->
        expect(viewModel.baseSpecificGravity()).toEqual '0.0'
      
    describe 'operatingTemperature', ->
      beforeEach ->
        field = viewModel.operatingTemperature
        validationMessage = 'Please enter the operating temperature'

      itBehavesLikeMandatoryField()
      
      it 'should have a default value of "0"', ->
        expect(viewModel.operatingTemperature()).toEqual '0'

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

      it 'should have a default value of "0"', ->
        expect(viewModel.differentialPressure()).toEqual '0'    

    describe 'orificeBoreDiameter', ->
      beforeEach ->
        field = viewModel.orificeBoreDiameter
        validationMessage = 'Please enter the orifice bore diameter'

      itBehavesLikeMandatoryField()
      
      it 'should have a default value of "0.0"', ->
        expect(viewModel.orificeBoreDiameter()).toEqual '0.0'
        
    describe 'compressibilityCorrection', ->
      it 'should have a default value of "None"', ->
        expect(viewModel.chosenCompressibilityCorrection()).toEqual 'None' 
        
      it 'should have None and Zf for compressibility correction', ->
        expect(viewModel.compressibilityCorrection()).toEqual [ 'None', 'Zf' ]

    describe 'betaRatio', ->
      it 'should return beta ratio', ->
        viewModel.selectedPipeID('8')
        viewModel.orificeBoreDiameter('2')
        expect(viewModel.betaRatio()).toEqual 0.25

    describe 'velocityOfApproach', ->
      it 'should return velocity of approach', ->
        viewModel.selectedPipeID('1.939')
        viewModel.orificeBoreDiameter('0.97')
        expect(viewModel.velocityOfApproach()).toEqual 1.04
        viewModel.orificeBoreDiameter('0.776')
        expect(viewModel.velocityOfApproach()).toEqual 1.02

    describe 'flowRate', ->
      it 'should return "0" as the default value', ->
        expect(viewModel.flowRate()).toEqual 0

      it 'should retun the flow rate', ->
        viewModel.orificeBoreDiameter('0.97')
        viewModel.selectedPipeID('1.939')
        viewModel.operatingPressure('900')
        viewModel.compressibilityCorrectionValue('1')
        viewModel.differentialPressure('30')
        viewModel.baseSpecificGravity('1')
        viewModel.operatingTemperature('60')
        expect(viewModel.flowRate()).toEqual 543.783
)
