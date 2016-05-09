describe 'orifice-calculator-view-spec', ->
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

  itShouldBehaveLikeTextInput = () ->
    it 'should be text input', ->
      expect($(element)).toEqual 'INPUT'
      expect($(element)).toHaveAttr('type', 'text')

  describe 'Pipe ID', ->
    beforeEach ->
      element = '#pipeID'
    itShouldBehaveLikeDropdownList()

  describe 'Operating Pressure', ->
    beforeEach -> 
      element = '#operatingPressure'
    itShouldBehaveLikeTextInput()

  describe 'Operating Pressure Read', ->
    beforeEach ->
      element = '.operatingPressureRead'
    itShouldBehaveLikeRadioButtons()

  describe 'Operating Pressure Units', ->
    beforeEach ->
      element = '#operatingPressureUnits'
    itShouldBehaveLikeDropdownList()

  describe 'Basic Specific Gravity', ->
    beforeEach ->
      element = '#baseSpecificGravity'
    itShouldBehaveLikeTextInput()

  describe 'Operating Temperature', ->
    beforeEach ->
      element = '#operatingTemperature'
    itShouldBehaveLikeTextInput()

  describe 'Operating Temperature Units', ->
    beforeEach ->
      element = '.operatingTemperatureUnits'
    itShouldBehaveLikeRadioButtons()

  describe 'Differential Pressure', ->
    beforeEach ->
      element = '#differentialPressure'
    itShouldBehaveLikeTextInput()

  describe 'Orifice Bore Diameter', ->
    beforeEach ->
      element = '#orificeBoreDiameter'
    itShouldBehaveLikeTextInput()

  describe 'Compressibility Correction', ->
    beforeEach ->
      element = '.compressibilityCorrection'
    itShouldBehaveLikeRadioButtons()
