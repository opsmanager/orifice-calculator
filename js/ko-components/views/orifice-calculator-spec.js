(function() {
  define("orifice-calculator-view-spec", ["jquery", "jasmine-jquery"], function($) {
    return describe("orifice-calculator-view-spec", function() {
      var itShouldBehaveLikeDropdownList, itShouldBehaveLikeNumberInput, itShouldBehaveLikeRadioButtons;
      beforeEach(function() {
        jasmine.getFixtures().fixturesPath = "js/ko-components/templates";
        return loadFixtures("orifice-calculator.html");
      });
      itShouldBehaveLikeRadioButtons = function(element) {
        return it("should be radio buttons", function() {
          return $(element).each(function() {
            expect($(this)).toEqual("INPUT");
            return expect($(this)).toHaveAttr("type", "radio");
          });
        });
      };
      itShouldBehaveLikeDropdownList = function(element) {
        return it("should be a dropdown list", function() {
          return expect($(element)).toEqual("SELECT");
        });
      };
      itShouldBehaveLikeNumberInput = function(element) {
        return it("should be number input", function() {
          expect($(element)).toEqual("INPUT");
          return expect($(element)).toHaveAttr("type", "number");
        });
      };
      describe("Available Pipes", function() {
        return itShouldBehaveLikeDropdownList("#available-pipes");
      });
      describe("Operating Pressure", function() {
        return itShouldBehaveLikeNumberInput("#operating-pressure");
      });
      describe("Operating Pressure Read", function() {
        return itShouldBehaveLikeRadioButtons(".operating-pressure-read");
      });
      describe("Operating Pressure Units", function() {
        return itShouldBehaveLikeDropdownList("#operating-pressure-units");
      });
      describe("Available Basic Specific Gravity", function() {
        return itShouldBehaveLikeDropdownList('#base-specific-gravity-select');
      });
      describe("Basic Specific Gravity", function() {
        return itShouldBehaveLikeNumberInput('#base-specific-gravity');
      });
      describe("Operating Temperature", function() {
        return itShouldBehaveLikeNumberInput("#operating-temperature");
      });
      describe("Operating Temperature Units", function() {
        return itShouldBehaveLikeRadioButtons(".operating-temperature-units");
      });
      describe("Differential Pressure", function() {
        return itShouldBehaveLikeNumberInput("input#differential-pressure");
      });
      describe("Calculated Differential Pressure", function() {
        return it("should be in the template", function() {
          return expect($("#calculated-differential-pressure")).toExist();
        });
      });
      describe("Orifice Bore Diameter", function() {
        return itShouldBehaveLikeNumberInput("#orifice-bore-diameter");
      });
      describe("Compressibility Correction", function() {
        return itShouldBehaveLikeRadioButtons(".compressibility-correction");
      });
      describe("Compressibility Correction Value", function() {
        return itShouldBehaveLikeNumberInput("#compressibility-correction-value");
      });
      describe("Calculated Flow Rate", function() {
        return it("should be in the template", function() {
          return expect($("#calculated-flow-rate")).toExist();
        });
      });
      describe("Flow Rate Input", function() {
        return itShouldBehaveLikeNumberInput("input#flow-rate");
      });
      describe("Flow Unit", function() {
        return itShouldBehaveLikeDropdownList('#flow-unit');
      });
      return describe("Flow Rate Unit", function() {
        return itShouldBehaveLikeDropdownList("#flow-rate-unit");
      });
    });
  });

}).call(this);
