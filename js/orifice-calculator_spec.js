(function() {
  define(['js/orifice-calculator.js'], function(orificeCalculator) {
    return describe('OrificeCalculatorViewModel', function() {
      var viewModel;
      viewModel = new orificeCalculator();
      describe('pipeID', function() {
        it('should have initialized the input data', function() {
          return expect(viewModel.pipeID().length).toEqual(6);
        });
        return it('should have default value of "1.939\'\' XS, Sch 80, Sch 80S"', function() {
          return expect(viewModel.selectedPipeID()).toEqual('1.939\'\' XS, Sch 80, Sch 80S');
        });
      });
      describe('operatingPressureRead', function() {
        it('should have "Gauge" and "Absolute"', function() {
          return expect(viewModel.operatingPressureRead()).toEqual(['Gauge', 'Absolute']);
        });
        return it('should have default value of "Gauge"', function() {
          return expect(viewModel.chosenOperatingPressureRead()).toEqual('Gauge');
        });
      });
      describe('operatingPressureUnits', function() {
        it('should have intialized the input data', function() {
          return expect(viewModel.operatingPressureUnits().length).toEqual(8);
        });
        return it('should have default value of "PSI"', function() {
          return expect(viewModel.selectedOperatingPressureUnits()).toEqual('PSI');
        });
      });
      describe('operatingTemperatureUnits', function() {
        it('should have default value of "Farenheit"', function() {
          return expect(viewModel.selectedOperatingTemperatureUnit()).toEqual('F');
        });
        return it('should have farenheit and celcius for operating temperature unit', function() {
          return expect(viewModel.operatingTemperatureUnit()).toEqual(['F', 'C']);
        });
      });
      return describe('compressibilityCorrection', function() {
        it('should have a default value of "None"', function() {
          return expect(viewModel.chosenCompressibilityCorrection()).toEqual('None');
        });
        return it('should have None and Zf for compressibility correction', function() {
          return expect(viewModel.compressibilityCorrection()).toEqual(['None', 'Zf']);
        });
      });
    });
  });

}).call(this);
