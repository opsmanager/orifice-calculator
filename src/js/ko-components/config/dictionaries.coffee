@OPL = {}
@OPL.OrificeCalculator ||= {}
@OPL.OrificeCalculator.Config ||= {}
@OPL.OrificeCalculator.Config.Dictionaries ||= {}

@OPL.OrificeCalculator.Config.Dictionaries.PipeID = {
  twoZeroInch: "2.067'' Sch 40, STD, Sch 40S"
  oneNineInch: "1.939'' XS, Sch 80, Sch 80S" # Default
  twoOneInch: "2.157'' Sch 10, Sch 10S"
  twoTwoInch: "2.245'' Sch 5, Sch 5S"
  oneSixInch: "1.687'' Sch 160"
  oneHalfInch: "1.503'' XXS"
}
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead = { gauge: 'Gauge', absolute: 'Absolute' }
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits = {
  psi: 'PSI'
  kgcm: 'kg/cm2'
  kpa: 'kPa'
  bar: 'bar'
  mmMercury: 'mm of Mercury'
  pa: 'Pa'
  mbar: 'mbar'
  inchesWC: 'inches of W.C'
}

@OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits = { fahrenheit: 'F', celsius: 'C' }
@OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection = { none: 'None', zf: 'Zf' }

@OPL.OrificeCalculator.Config.Dictionaries.Messages = {
  operatingPressureWarning: 'At this pressure, no compressibility correction may result in erroneous computations'
  operatingPressureError: 'At this pressure, no compressibility correction will result in erroneous computations'
  floatError: 'Please enter a float'
  integerError: 'Please enter an integer'
  baseSpecificGravityError: 'Please enter the base specific gravity'
  operatingTemperatureError: 'Please enter the operating temperature'
  differentialPressureError: 'Please enter the differential pressure'
  orificeBoreDiameterError: 'Please enter the orifice bore diameter'
}
