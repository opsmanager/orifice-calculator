define "orifice-calculator-config", () ->
  @OPL ||= {}
  @OPL.OrificeCalculator ||= {}
  @OPL.OrificeCalculator.Config ||= {}
  @OPL.OrificeCalculator.Config.Dictionaries ||= {}

  @OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes =
    twoZeroInch:
      name: "2.067\" Sch 40, STD, Sch 40S"
      value: 2.067
    oneNineInch:
      name: "1.939\" XS, Sch 80, Sch 80S"
      value: 1.939
    twoOneInch:
      name: "2.157\" Sch 10, Sch 10S"
      value: 2.157
    twoTwoInch:
      name: "2.245\" Sch 5, Sch 5S"
      value: 2.245
    oneSixInch:
      name: "1.687\" Sch 160"
      value: 1.687
    oneHalfInch:
      name: "1.503\" XXS"
      value: 1.503

  @OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead =
    gauge: "Gauge"
    absolute: "Absolute"

  @OPL.OrificeCalculator.Config.Dictionaries.PressureUnits =
    psi: "PSI"
    kgcm: "kg/cm2"
    bar: "bar"
    mbar: "mbar"
    mmMercury: "mm of Mercury"
    inchesMercury: "Inches Mercury"
    kpa: "kPa"
    pa: "Pa"
    mmWater: "mm of Water"
    inchesWater: "Inches Water"

  @OPL.OrificeCalculator.Config.Dictionaries.OrificeBoreDiameterUnits =
    inches: "Inches"
    millimiters: "Millimiters"
    centimeters: "Centimeters"

  @OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits =
    fahrenheit: "F"
    celsius: "C"

  @OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection =
    none: "None"
    zf: "Zf"

  @OPL.OrificeCalculator.Config.Dictionaries.Messages =
    operatingPressureError: "Please enter the operating pressure"
    operatingPressureWarningMayResult: "At this pressure, no compressibility correction may result in erroneous computations"
    operatingPressureWarningWillResult: "At this pressure, no compressibility correction will result in erroneous computations"
    floatError: "Please enter a float"
    integerError: "Please enter an integer"
    baseSpecificGravityError: "Please enter the base specific gravity"
    operatingTemperatureError: "Please enter the operating temperature"
    differentialPressureError: "Please enter the differential pressure"
    orificeBoreDiameterError: "Please enter the orifice bore diameter"

  @OPL.OrificeCalculator.Config.Dictionaries.AvailableFlowRateUnits =
    minute: "Minute"
    hour: "Hour"
    day: "Day"
    second: "Second"
