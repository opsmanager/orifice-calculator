define 'ko-extenders-spec', ['knockout', 'jasmine-boot', 'ko-extenders'], (ko) ->
  describe 'ko-extenders', ->
    it 'should return Number when toNumber extender is used', ->
      viewModel = { numberField: ko.observable().extend(toNumber: true) }
      viewModel.numberField('123e1')
      expect(typeof viewModel.numberField()).toEqual 'number'
