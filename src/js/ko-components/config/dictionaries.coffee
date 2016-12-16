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

  @OPL.OrificeCalculator.Config.Dictionaries.PressureUnits = [
    {
      displayName: "Psi"
      key: "psi"
    }
    {
      displayName: "kg/cm2"
      key: "kgcm2"
    }
    {
      displayName: "Bar"
      key: "bar"
    }
    {
      displayName: "mBar"
      key: "mbar"
    }
    {
      displayName: "mm of Mercury"
      key: "mmhg"
    }
    {
      displayName: "in of Mercury"
      key: "inhg"
    }
    {
      displayName: "kPa"
      key: "kpa"
    }
    {
      displayName: "Pa"
      key: "pa"
    }
    {
      displayName: "mm of Water"
      key: "mmh2o"
    }
    {
      displayName: "in of Water"
      key: "inh2o"
    }
  ]
  @OPL.OrificeCalculator.Config.Dictionaries.BaseSpecificGravity =
    air:
      name: "Air"
      value: 1
    pureNitrogen:
      name: "100% N2"
      value: 0.9669
    ninetySixPercentNitrogen:
      name: "96% N2"
      value: 0.968
    methane:
      name: "Methane"
      value: 0.5537

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

  @OPL.OrificeCalculator.Config.Dictionaries.FlowRatePressureUnits =
    standardCubicFeet: "Standard Cubic Feet"
    pounds: "Pounds"
    kilograms: "Kilograms"
    standardCubicMeters: "Standard Cubic Meters"

  @OPL.OrificeCalculator.Config.Dictionaries.FlowRateTimeUnits =
    minute: "Minute"
    hour: "Hour"
    day: "Day"
    second: "Second"

  @OPL.OrificeCalculator.Config.Dictionaries.CalculationField =
    flowRate: "flow rate"
    differentialPressure: "differential pressure"
