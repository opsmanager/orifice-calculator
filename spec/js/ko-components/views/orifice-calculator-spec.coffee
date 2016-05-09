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
      element = '#pipe-id'
    itShouldBehaveLikeDropdownList()

  describe 'Operating Pressure', ->
    beforeEach -> 
      element = '#operating-pressure'
    itShouldBehaveLikeTextInput()

  describe 'Operating Pressure Read', ->
    beforeEach ->
      element = '.operating-pressure-read'
    itShouldBehaveLikeRadioButtons()

  describe 'Operating Pressure Units', ->
    beforeEach ->
      element = '#operating-pressure-units'
    itShouldBehaveLikeDropdownList()

  describe 'Basic Specific Gravity', ->
    beforeEach ->
      element = '#base-specific-gravity'
    itShouldBehaveLikeTextInput()

  describe 'Operating Temperature', ->
    beforeEach ->
      element = '#operating-temperature'
    itShouldBehaveLikeTextInput()

  describe 'Operating Temperature Units', ->
    beforeEach ->
      element = '.operating-temperature-units'
    itShouldBehaveLikeRadioButtons()

  describe 'Differential Pressure', ->
    beforeEach ->
      element = '#differential-pressure'
    itShouldBehaveLikeTextInput()

  describe 'Orifice Bore Diameter', ->
    beforeEach ->
      element = '#orifice-bore-diameter'
    itShouldBehaveLikeTextInput()

  describe 'Compressibility Correction', ->
    beforeEach ->
      element = '.compressibility-correction'
    itShouldBehaveLikeRadioButtons()
