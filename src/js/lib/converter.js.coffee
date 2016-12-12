define "unit-converter", ["lodash"], (_) ->
  @OPL ||= {}
  @OPL.Converter ||= {}
  @OPL.Converter.Dimensions ||= {}
  @OPL.Converter.Temperature ||= {}
  @OPL.Converter.Pressure ||= {}

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
    ONE_KGCM2_IN_PSI: 14.22334
    ONE_KPA_IN_PSI: 0.14504
    ONE_BAR_IN_PSI: 14.50377

    kgcm2ToPSI: (value) ->
      value * @ONE_KGCM2_IN_PSI

    kpaToPSI: (value) ->
      value * @ONE_KPA_IN_PSI

    barToPSI: (value) ->
      value * @ONE_BAR_IN_PSI
