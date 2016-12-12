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
    ONE_KGCM2_IN_INH2O: 394.095
    ONE_KPA_IN_PSI: 0.14504
    ONE_KPA_IN_INH2O: 4.01865
    ONE_BAR_IN_PSI: 14.50377
    ONE_BAR_IN_INH2O: 401.865
    ONE_MMHG_IN_PSI: 0.019336721269668
    ONE_MMHG_IN_INH2O: 0.535776
    ONE_PA_IN_PSI: 0.00014503773773022
    ONE_PA_IN_INH2O: 0.00401865
    ONE_INH2O_IN_PSI: 0.036126
    ONE_PSI_IN_INH2O: 27.7076

    kgcm2ToPSI: (value) ->
      value * @ONE_KGCM2_IN_PSI

    kpaToPSI: (value) ->
      value * @ONE_KPA_IN_PSI

    barToPSI: (value) ->
      value * @ONE_BAR_IN_PSI

    mbarToPSI: (value) ->
      value * @ONE_BAR_IN_PSI/1000

    # NOTE: At 0 deg C
    mmHgToPSI: (value) ->
      value * @ONE_MMHG_IN_PSI

    paToPSI: (value) ->
      value * @ONE_PA_IN_PSI

    inWaterToPSI: (value) ->
      value * @ONE_INH2O_IN_PSI

    kgcm2ToInWater: (value) ->
      value * @ONE_KGCM2_IN_INH2O

    kpaToInWater: (value) ->
      value * @ONE_KPA_IN_INH2O

    barToInWater: (value) ->
      value * @ONE_BAR_IN_INH2O

    mbarToInWater: (value) ->
      value * @ONE_BAR_IN_INH2O/1000

    # NOTE: At 0 deg C
    mmHgToInWater: (value) ->
      value * @ONE_MMHG_IN_INH2O

    paToInWater: (value) ->
      value * @ONE_PA_IN_PSI

    psiToInWater: (value) ->
      value * @ONE_PSI_IN_INH2O
