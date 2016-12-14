define "unit-converter", ["lodash"], (_) ->
  @OPL ||= {}
  @OPL.Converter ||= {}
  @OPL.Converter.Dimensions ||= {}
  @OPL.Converter.Temperature ||= {}
  @OPL.Converter.Pressure ||= {}
  @OPL.Converter.Flowrate ||= {}

  _.extend @OPL.Converter.Dimensions,
    ONE_CM_IN_INCHES: 0.3937007874

    cmToInches: (value) ->
      value * @ONE_CM_IN_INCHES

    mmToInches: (value) ->
      (value / 10) * @ONE_CM_IN_INCHES

  _.extend @OPL.Converter.Temperature,
    F_ABSOLUTE_ZERO_RANKINE: 459.67
    C_ABSOLUTE_ZERO_RANKINE: 273.15
    C_R_RELATION: 9/5

    fToRankin: (value) ->
      value + @F_ABSOLUTE_ZERO_RANKINE

    cToRankin: (value) ->
      (value + @C_ABSOLUTE_ZERO_RANKINE) * @C_R_RELATION

  _.extend @OPL.Converter.Pressure,
    CONSTANTS:
      "kgcm2":
        "psi": 14.22334
        "inh2o": 394.094598
      "kpa":
        "psi": 0.14503773
        "inh2o": 4.0186465
      "bar":
        "psi": 14.50377377
        "inh2o": 401.8646519
      "mbar":
        "psi": 0.01450377377
        "inh2o": 0.4018646519
      "inhg":
        "psi": 0.4911540
        "inh2o": 13.6086969
      "mmhg":
        "psi": 0.0193367747
        "inh2o": 0.535776
      "pa":
        "psi": 0.00014503773773022
        "inh2o": 0.00401865
      "inh2o":
        "psi": 0.036126
      "mmh2o":
        "psi": 0.0014223
        "inh2o": 0.039370087
      "psi":
        "inh2o": 27.7075924

    convert: (from, to, value) ->
      @CONSTANTS[from][to] * value

  _.extend @OPL.Converter.Flowrate,
    # STANDARD_AIR_DENSITY: 1.225
    # AMERICAN_AIR_DENSITY: 0.0765

    CONSTANTS:
      "Standard Cubic Feet":
        "Pounds": 0.0765
        "Kilograms": 0.3048 ** 3 * 1.225
        "Standard Cubic Meters": 0.3048 ** 3
      # "Pounds":
      #   "Standard Cubic Feet": 1 / 0.0765
      #   "Kilograms": 0.454
      #   "Standard Cubic Meters": 0.454 / 1.225
      # "Kilograms":
      #   "Pounds": 1 / 0.454
      #   "Standard Cubic Feet": (1 / 0.454) / 0.0765
      #   "Standard Cubic Meters": 1.225
      # "Standard Cubic Meters":
      #   "Pounds": ( 1.225 / 0.454 )
      #   "Kilograms": 1 / 1.225
      #   "Standard Cubic Feet": 3.281 ** 3

    convert: (from, to, value) ->
      @CONSTANTS[from][to] * value
