describe 'orifice-calculator-view-spec', ->
  templateElements = null
  element = null

  beforeEach ->
    jasmine.getFixtures().fixturesPath = 'js/ko-components/templates'
    loadFixtures('orifice-calculator.html')

  itShouldBehaveLikeRadioButtons = () ->
    it 'should be radio buttons', ->
      $(element).each ->
        expect($(this)).toEqual 'INPUT'
        expect($(this)).toHaveAttr('type', 'radio')

  itShouldBehaveLikeDropdownList = () ->
    it 'should be a dropdown list', ->
      expect($(element)).toEqual 'SELECT'

  describe 'Pipe ID', ->
    beforeEach ->
      element = '#pipeID'
    itShouldBehaveLikeDropdownList()

  describe 'Operating Pressure Units', ->
    beforeEach ->
      element = '#operatingPressureUnits'
    itShouldBehaveLikeDropdownList()

  describe 'Operating Pressure Read', ->
    beforeEach ->
      element = '.operatingPressureRead'
    itShouldBehaveLikeRadioButtons()

  describe 'Operating Temperature Units', ->
    beforeEach ->
      element = '.operatingTemperatureUnits'
    itShouldBehaveLikeRadioButtons()

  describe 'Compressibility Correction', ->
    beforeEach ->
      element = '.compressibilityCorrection'
    itShouldBehaveLikeRadioButtons()
