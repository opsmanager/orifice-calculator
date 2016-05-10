@OPL = {}
@OPL.OrificeCalculator ||= {}
@OPL.OrificeCalculator.Config ||= {}
@OPL.OrificeCalculator.Config.Dictionaries ||= {}

@OPL.OrificeCalculator.Config.Dictionaries.PipeID = {
  two_zero_inch: "2.067'' Sch 40, STD, Sch 40S"
  one_nine_inch: "1.939'' XS, Sch 80, Sch 80S" # Default
  two_one_inch: "2.157'' Sch 10, Sch 10S"
  two_two_inch: "2.245'' Sch 5, Sch 5S"
  one_six_inch: "1.687'' Sch 160"
  one_half_inch: "1.503'' XXS"
}
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead = { gauge: 'Gauge', absolute: 'Absolute' }
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits = {
  psi: 'PSI'
  kgcm: 'kg/cm2'
  kpa: 'kPa'
  bar: 'bar'
  mm_mercury: 'mm of Mercury'
  pa: 'Pa'
  mbar: 'mbar'
  inches_wc: 'inches of W.C'
}

@OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits = { fahrenheit: 'F', celsius: 'C' }
@OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection = { none: 'None', zf: 'Zf' }

@OPL.OrificeCalculator.Config.Dictionaries.Messages = {
  warning: 'At this pressure, no compressibility correction may result in erroneous computations'
  error: 'At this pressure, no compressibility correction will result in erroneous computations'
  float: 'Please enter a float'
  integer: 'Please enter an integer'
  base_specific_gravity: 'Please enter the base specific gravity'
  operating_temperature: 'Please enter the operating temperature'
  differential_pressure: 'Please enter the differential pressure'
  orifice_bore_diameter: 'Please enter the orifice bore diameter'
}
