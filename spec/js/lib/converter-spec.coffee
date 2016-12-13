define "unit-converter-spec", ["jasmine-boot", "unit-converter"], ->
  describe "unit-converter-spec", ->
    describe "Dimensions", ->
      it "converts cm to in", ->
        expect(OPL.Converter.Dimensions.cmToInches(10)).toEqual 3.937007874

      it "converts mm to in", ->
        expect(OPL.Converter.Dimensions.mmToInches(12)).toEqual 0.47244094487999994

    describe "Temperature", ->
      it "converts Fahrenheit to Rankine", ->
        # NOTE: for some reason the result is 519.6700000000001, so we need to make it match
        expect(Math.round(OPL.Converter.Temperature.fToRankin(60)*100)/100).toEqual 519.67

      it "converts Celsius to Rankine", ->
        expect(OPL.Converter.Temperature.cToRankin(60)).toEqual 599.67

    describe "Pressure", ->
