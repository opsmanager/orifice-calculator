(function() {
  define("unit-converter", ["lodash"], function(_) {
    var base, base1, base2, base3, base4;
    this.OPL || (this.OPL = {});
    (base = this.OPL).Converter || (base.Converter = {});
    (base1 = this.OPL.Converter).Dimensions || (base1.Dimensions = {});
    (base2 = this.OPL.Converter).Temperature || (base2.Temperature = {});
    (base3 = this.OPL.Converter).Pressure || (base3.Pressure = {});
    (base4 = this.OPL.Converter).FlowRate || (base4.FlowRate = {});
    _.extend(this.OPL.Converter.Dimensions, {
      ONE_CM_IN_INCHES: 0.3937007874,
      cmToInches: function(value) {
        return value * this.ONE_CM_IN_INCHES;
      },
      mmToInches: function(value) {
        return (value / 10) * this.ONE_CM_IN_INCHES;
      }
    });
    _.extend(this.OPL.Converter.Temperature, {
      F_ABSOLUTE_ZERO_RANKINE: 459.67,
      C_ABSOLUTE_ZERO_RANKINE: 273.15,
      C_R_RELATION: 9 / 5,
      fToRankin: function(value) {
        return value + this.F_ABSOLUTE_ZERO_RANKINE;
      },
      cToRankin: function(value) {
        return (value + this.C_ABSOLUTE_ZERO_RANKINE) * this.C_R_RELATION;
      }
    });
    _.extend(this.OPL.Converter.Pressure, {
      CONSTANTS: {
        "kgcm2": {
          "psi": 14.22334,
          "inh2o": 394.094598
        },
        "kpa": {
          "psi": 0.14503773,
          "inh2o": 4.0186465
        },
        "bar": {
          "psi": 14.50377377,
          "inh2o": 401.8646519
        },
        "mbar": {
          "psi": 0.01450377377,
          "inh2o": 0.4018646519
        },
        "inhg": {
          "psi": 0.4911540,
          "inh2o": 13.6086969
        },
        "mmhg": {
          "psi": 0.0193367747,
          "inh2o": 0.535776
        },
        "pa": {
          "psi": 0.00014503773773022,
          "inh2o": 0.00401865
        },
        "inh2o": {
          "psi": 0.036126
        },
        "mmh2o": {
          "psi": 0.0014223,
          "inh2o": 0.039370087
        },
        "psi": {
          "inh2o": 27.7075924
        }
      },
      convert: function(from, to, value) {
        return this.CONSTANTS[from][to] * value;
      }
    });
    return _.extend(this.OPL.Converter.FlowRate, {
      CONSTANTS: {
        "Standard Cubic Feet": {
          "Pounds": 0.0765,
          "Kilograms": Math.pow(0.3048, 3) * 1.225,
          "Standard Cubic Meters": Math.pow(0.3048, 3)
        }
      },
      convert: function(from, to, value) {
        return this.CONSTANTS[from][to] * value;
      }
    });
  });

}).call(this);
