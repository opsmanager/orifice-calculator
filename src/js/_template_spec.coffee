define(['text!_template.html'], (template) ->
#TODO: specs for labels
  describe '_template.html', ->
    templateElements = null
    element = null
    
    beforeAll ->
      tmp = document.implementation.createHTMLDocument()
      tmp.body.innerHTML = template
      templateElements = tmp.body.children[0]

    itShouldBehaveLikeRadioButtons = () ->
      it 'should be radio buttons', ->
        _.each(element, (el) ->
          expect(el.tagName).toEqual 'INPUT'
          expect(el.getAttribute('type')).toEqual 'radio'
        )

    itShouldBehaveLikeTextInput = () ->
      it 'should be text input', ->
        expect(element.tagName).toEqual 'INPUT'
        expect(element.getAttribute('type')).toEqual 'text'

    itShouldBehaveLikeDropdownList = () ->
      it 'should be a dropdown list', ->
        expect(element.tagName).toEqual 'SELECT'
        
    describe 'Pipe ID', ->
      beforeEach ->
        element = templateElements.querySelector('#pipeID')
      itShouldBehaveLikeDropdownList()

    describe 'Operating Pressure', ->
      beforeEach -> 
        element = templateElements.querySelector('#operatingPressure')
      itShouldBehaveLikeTextInput()

    describe 'Operating Pressure Read', ->
      beforeEach ->
        element = templateElements.querySelectorAll('.operatingPressureRead')
      itShouldBehaveLikeRadioButtons()

    describe 'Operating Pressure Units', ->
      beforeEach -> 
        element = templateElements.querySelector('#operatingPressureUnits')
      itShouldBehaveLikeDropdownList()

    describe 'Basic Specific Gravity', ->
      beforeEach ->
        element = templateElements.querySelector('#baseSpecificGravity')
      itShouldBehaveLikeTextInput()

    describe 'Operating Temperature', ->
      beforeEach ->
        element = templateElements.querySelector('#operatingTemperature')
      itShouldBehaveLikeTextInput()

    describe 'Operating Temperature Units', ->
      beforeEach ->
        element = templateElements.querySelectorAll('.operatingTemperatureUnit')
      itShouldBehaveLikeRadioButtons()

    describe 'Differential Pressure', ->
      beforeEach ->
        element = templateElements.querySelector('#differentialPressure')
      itShouldBehaveLikeTextInput()

    describe 'Orifice Bore Diameter', ->
      beforeEach ->
        element = templateElements.querySelector('#orificeBoreDiameter')
      itShouldBehaveLikeTextInput()

    describe 'Compressibility Correction', ->
      beforeEach ->
        element = templateElements.querySelectorAll('.compressibilityCorrection')
      itShouldBehaveLikeRadioButtons()

      describe 'Value', ->
        beforeEach ->
          element = templateElements.querySelector('#compressibilityCorrectionValue')
        itShouldBehaveLikeTextInput()

    describe 'Flow Rate Unit', ->
      beforeEach ->
        element = templateElements.querySelector('#flowRateUnit')
      itShouldBehaveLikeDropdownList()
)
