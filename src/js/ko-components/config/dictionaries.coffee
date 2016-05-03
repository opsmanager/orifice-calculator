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

@OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnit = { fahrenheit: 'F', celsius: 'C' } 
@OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection = { none: 'None', zf: 'Zf' } 

