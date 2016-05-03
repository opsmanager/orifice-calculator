App.ViewModels ||= {}

class App.ViewModels.OrificeCalculator
  constructor: ->
    @pipeID = [
               "2.067'' Sch 40, STD, Sch 40S"
               "1.939'' XS, Sch 80, Sch 80S"
               "2.157'' Sch 10, Sch 10S"
               "2.245'' Sch 5, Sch 5S"
               "1.687'' Sch 160"
               "1.503'' XXS"
              ]
    @operatingPressure # integer
    @operatingPressureRead = [ 'Gauge', 'Absolute' ]
    @operatingPressureUnits = [ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ]
    @baseSpecificGravity # float
    @operatingTemperature # float
    @operatingTemperatureUnit = [ 'F', 'C' ]
    @differentialPressure # integer (Inches Water)
    @orificeBoreDiameter # float (Inches)
    @compressibilityCorrection = [ 'None', 'Zf' ]  
