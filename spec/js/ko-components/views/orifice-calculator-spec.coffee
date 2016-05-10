define 'orifice-calculator-view-spec', ['jasmine-jquery'], () ->
  describe 'orifice-calculator-view-spec', ->

    beforeEach ->
      jasmine.getFixtures().fixturesPath = 'js/ko-components/templates'
      loadFixtures 'orifice-calculator.html'

    itShouldBehaveLikeRadioButtons = (element) ->
      it 'should be radio buttons', ->
        $(element).each ->
          expect($(this)).toEqual 'INPUT'
          expect($(this)).toHaveAttr 'type', 'radio'

    itShouldBehaveLikeDropdownList = (element) ->
      it 'should be a dropdown list', ->
        expect($(element)).toEqual 'SELECT'

    itShouldBehaveLikeNumberInput = (element) ->
      it 'should be number input', ->
        expect($(element)).toEqual 'INPUT'
        expect($(element)).toHaveAttr 'type', 'number'

    describe 'Pipe ID', ->
      itShouldBehaveLikeDropdownList '#pipe-id'

    describe 'Operating Pressure', ->
      itShouldBehaveLikeNumberInput '#operating-pressure'

    describe 'Operating Pressure Read', ->
      itShouldBehaveLikeRadioButtons '.operating-pressure-read'

    describe 'Operating Pressure Units', ->
      itShouldBehaveLikeDropdownList '#operating-pressure-units'

    describe 'Basic Specific Gravity', ->
      itShouldBehaveLikeNumberInput '#base-specific-gravity'

    describe 'Operating Temperature', ->
      itShouldBehaveLikeNumberInput '#operating-temperature'

    describe 'Operating Temperature Units', ->
      itShouldBehaveLikeRadioButtons '.operating-temperature-units'

    describe 'Differential Pressure', ->
      itShouldBehaveLikeNumberInput '#differential-pressure'

    describe 'Orifice Bore Diameter', ->
      itShouldBehaveLikeNumberInput '#orifice-bore-diameter'

    describe 'Compressibility Correction', ->
      itShouldBehaveLikeRadioButtons '.compressibility-correction'
