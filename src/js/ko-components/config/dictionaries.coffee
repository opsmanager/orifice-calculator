@OPL = {}
@OPL.OrificeCalculator ||= {}
@OPL.OrificeCalculator.Config ||= {}
@OPL.OrificeCalculator.Config.Dictionaries ||= {}

@OPL.OrificeCalculator.Config.Dictionaries.PipeID =
  2.067: "2.067'' Sch 40, STD, Sch 40S"
  1.939: "1.939'' XS, Sch 80, Sch 80S"
  2.157: "2.157'' Sch 10, Sch 10S"
  2.245: "2.245'' Sch 5, Sch 5S"
  1.687: "1.687'' Sch 160"
  1.503: "1.503'' XXS"

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
  operatingPressureError: 'Please enter the operating pressure'
  operatingPressureWarningMayResult: 'At this pressure, no compressibility correction may result in erroneous computations'
  operatingPressureWarningWillResult: 'At this pressure, no compressibility correction will result in erroneous computations'
  floatError: 'Please enter a float'
  integerError: 'Please enter an integer'
  baseSpecificGravityError: 'Please enter the base specific gravity'
  operatingTemperatureError: 'Please enter the operating temperature'
  differentialPressureError: 'Please enter the differential pressure'
  orificeBoreDiameterError: 'Please enter the orifice bore diameter'
}
