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
      it "converts multiple units to psi", ->
        expectedResult = [824.95372, 8.41218834, 0.008412188788352759, 841.21887866, 0.84121887866, 1.1215329326, 28.486932, 2.0953079999999997, 0.08249340000000001]
        ["kgcm2", "kpa", "pa", "bar", "mbar", "mmhg", "inhg", "inh2o", "mmh2o"].forEach (from, index) ->
          expect(OPL.Converter.Pressure.convert(from, "psi", 58)).toEqual expectedResult[index]

      it "converts multiple units to inh2o", ->
        expectedResult = [9064.175754, 92.4288695, 0.09242895000000001, 9242.8869937, 9.242886993699999, 12.322848, 313.0000287, 0.905512001, 637.2746252]
        ["kgcm2", "kpa", "pa", "bar", "mbar", "mmhg", "inhg", "mmh2o", "psi"].forEach (from, index) ->
          expect(OPL.Converter.Pressure.convert(from, "inh2o", 23)).toEqual expectedResult[index]
