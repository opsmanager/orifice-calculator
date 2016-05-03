define(['knockout'], (ko) ->
  class OrificeCalculator
    constructor: ->
      @pipeID = ko.observableArray([
               "2.067'' Sch 40, STD, Sch 40S"
               "1.939'' XS, Sch 80, Sch 80S" # Default
               "2.157'' Sch 10, Sch 10S"
               "2.245'' Sch 5, Sch 5S"
               "1.687'' Sch 160"
               "1.503'' XXS"
              ])

      @selectedPipeID = ko.observable(1)
      @operatingPressure = ko.observable() # integer 
      @operatingPressureRead = [ 'Gauge', 'Absolute' ]
      @operatingPressureUnits = [ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ]
      @baseSpecificGravity = ko.observable() # float
      @operatingTemperature = ko.observable() # float
      @operatingTemperatureUnit = [ 'F', 'C' ]
      @differentialPressure = ko.observable() # integer (Inches Water)
      @orificeBoreDiameter = ko.observable() # float (Inches)
      @compressibilityCorrection = [ 'None', 'Zf' ]
)
