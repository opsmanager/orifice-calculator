define 'orifice-calculator-view-spec', ['jquery', 'jasmine-jquery'], ($) ->
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

    describe 'Available Pipes', ->
      itShouldBehaveLikeDropdownList '#available-pipes'

    describe 'Operating Pressure', ->
      itShouldBehaveLikeNumberInput '#operating-pressure'

    describe 'Operating Pressure Read', ->
      itShouldBehaveLikeRadioButtons '.operating-pressure-read'

    describe 'Operating Pressure Units', ->
      itShouldBehaveLikeDropdownList '#operating-pressure-units'

    describe 'Available Basic Specific Gravity', ->
      itShouldBehaveLikeDropdownList '#base-specific-gravity-select'

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

    describe 'Compressibility Correction Value', ->
      itShouldBehaveLikeNumberInput '#compressibility-correction-value'

    describe 'Flow Rate', ->
      it 'should be in the template', ->
        expect($('#flow-rate')).toExist()

    describe 'Flow Unit', ->
      itShouldBehaveLikeDropdownList '#flow-unit'

    describe 'Flow Rate Unit', ->
      itShouldBehaveLikeDropdownList '#flow-rate-unit'
