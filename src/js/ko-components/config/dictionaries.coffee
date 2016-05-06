@OPL = {}
@OPL.OrificeCalculator ||= {}
@OPL.OrificeCalculator.Config ||= {}
@OPL.OrificeCalculator.Config.Dictionaries ||= {}

@OPL.OrificeCalculator.Config.Dictionaries.PipeID = [
             "2.067'' Sch 40, STD, Sch 40S"
             "1.939'' XS, Sch 80, Sch 80S" # Default
             "2.157'' Sch 10, Sch 10S"
             "2.245'' Sch 5, Sch 5S"
             "1.687'' Sch 160"
             "1.503'' XXS"
            ]
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead = [ 'Gauge', 'Absolute' ]
@OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits = [ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ]
@OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnit = [ 'F', 'C' ]
@OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection = [ 'None', 'Zf' ]

