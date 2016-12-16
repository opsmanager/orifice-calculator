(function() {
  define("unit-converter-spec", ["jasmine-boot", "unit-converter"], function() {
    return describe("unit-converter-spec", function() {
      describe("Dimensions", function() {
        it("converts cm to in", function() {
          return expect(OPL.Converter.Dimensions.cmToInches(10)).toEqual(3.937007874);
        });
        return it("converts mm to in", function() {
          return expect(OPL.Converter.Dimensions.mmToInches(12)).toEqual(0.47244094487999994);
        });
      });
      describe("Temperature", function() {
        it("converts Fahrenheit to Rankine", function() {
          return expect(Math.round(OPL.Converter.Temperature.fToRankin(60) * 100) / 100).toEqual(519.67);
        });
        return it("converts Celsius to Rankine", function() {
          return expect(OPL.Converter.Temperature.cToRankin(60)).toEqual(599.67);
        });
      });
      return describe("Pressure", function() {
        it("converts multiple units to psi", function() {
          var expectedResult;
          expectedResult = [824.95372, 8.41218834, 0.008412188788352759, 841.21887866, 0.84121887866, 1.1215329326, 28.486932, 2.0953079999999997, 0.08249340000000001];
          return ["kgcm2", "kpa", "pa", "bar", "mbar", "mmhg", "inhg", "inh2o", "mmh2o"].forEach(function(from, index) {
            return expect(OPL.Converter.Pressure.convert(from, "psi", 58)).toEqual(expectedResult[index]);
          });
        });
        return it("converts multiple units to inh2o", function() {
          var expectedResult;
          expectedResult = [9064.175754, 92.4288695, 0.09242895000000001, 9242.8869937, 9.242886993699999, 12.322848, 313.0000287, 0.905512001, 637.2746252];
          return ["kgcm2", "kpa", "pa", "bar", "mbar", "mmhg", "inhg", "mmh2o", "psi"].forEach(function(from, index) {
            return expect(OPL.Converter.Pressure.convert(from, "inh2o", 23)).toEqual(expectedResult[index]);
          });
        });
      });
    });
  });

}).call(this);
