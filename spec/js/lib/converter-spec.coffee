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

      it "converts multiple units from inh2o", ->
        expectedResult = [0.0583625, 5.72332, 5723.31494, 0.0572332, 57.2332, 42.92835, 1.6900860000000002, 584.19977, 0.8308979999999999 ]
        ["kgcm2", "kpa", "pa", "bar", "mbar", "mmhg", "inhg", "mmh2o", "psi"].forEach (to, index) ->
          expect(OPL.Converter.Pressure.convert("inh2o", to, 23)).toEqual expectedResult[index]

    describe "FlowRate", ->
      it "converts multiple units to StandardCubicFeet", ->
        expectedResult = [1307.2, 2882.8, 3531.5]
        ["Pounds", "Kilograms", "Standard Cubic Meters"].forEach (from, index) ->
          expect(_.ceil OPL.Converter.FlowRate.convert(from, "Standard Cubic Feet", 100), 1).toEqual expectedResult[index]

      it "converts from standardCubicFeet to multiple units", ->
        expectedResult = [7.65, 3.47, 2.83]
        ["Pounds", "Kilograms", "Standard Cubic Meters"].forEach (to, index) ->
          expect(_.ceil OPL.Converter.FlowRate.convert("Standard Cubic Feet", to, 100), 2).toEqual expectedResult[index]

    describe "Rate", ->
      it "converts multiple units to hour", ->
        expectedResult = [3600, 2.5, 216000]
        ["Minute", "Day", "Second"].forEach (from, index) ->
          expect(OPL.Converter.Rate.convert(from, "Hour", 60)).toEqual expectedResult[index]

      it "converts multiple units from hour", ->
        expectedResult = [1, 1440, 0.016666666666666666]
        ["Minute", "Day", "Second"].forEach (to, index) ->
          expect(OPL.Converter.Rate.convert("Hour", to, 60)).toEqual expectedResult[index]
