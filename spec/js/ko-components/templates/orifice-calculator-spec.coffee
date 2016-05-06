describe 'template-orifice-calculator-spec', ->
  templateElements = null
  element = null

  beforeAll ->
    jasmine.getFixtures().fixturesPath = 'build/js/ko-components/templates'
    loadFixtures('orifice-calculator.html')

  itShouldBehaveLikeRadioButtons = (elementArray) ->
    it 'should be radio buttons', ->
      _.each(elementArray, (el) ->
        expect(el.tagName).toEqual 'INPUT'
        expect(el.getAttribute('type')).toEqual 'radio'
      )

  itShouldBehaveLikeDropdownList = (element) ->
    it 'should be a dropdown list', ->
      expect(element.tagName).toEqual 'SELECT'

  describe 'Pipe ID', ->
    it 'should be a dropdown list', ->
      expect($('#pipeID')).toExist()

  describe 'Operating Pressure Units', ->
    element = templateElements.querySelector('[data-bind="options: operatingPressureUnits, value: selectedOperatingPressureUnits"]')
    itShouldBehaveLikeDropdownList(element)    

  describe 'Operating Pressure Read', ->
    elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.chosenOperatingPressureRead"]')
    itShouldBehaveLikeRadioButtons(elementArray)

  describe 'Operating Temperature Units', ->
    elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.selectedOperatingTemperatureUnit"]')
    itShouldBehaveLikeRadioButtons(elementArray)
 
  describe 'Compressibility Correction', ->
    elementArray = templateElements.querySelectorAll('[data-bind="checkedValue: $data, checked: $component.chosenCompressibilityCorre5ction"]')
    itShouldBehaveLikeRadioButtons(elementArray)
