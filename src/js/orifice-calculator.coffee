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

      @selectedPipeID = ko.observable(@pipeID()[1])
      @operatingPressure = ko.observable() # integer 
      @operatingPressureRead = ko.observableArray([ 'Gauge', 'Absolute' ])
      @chosenOperatingPressureRead = ko.observableArray([@operatingPressureRead()[0]])
      
      @operatingPressureUnits = ko.observableArray([ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ])
      @selectedOperatingPressureUnits = ko.observable(@operatingPressureUnits()[0])

      @baseSpecificGravity = ko.observable() # float
      @operatingTemperature = ko.observable() # float
      @operatingTemperatureUnit = ko.observableArray([ 'F', 'C' ])
      @selectedOperatingTemperatureUnit = ko.observable(@operatingTemperatureUnit()[0])

      @differentialPressure = ko.observable() # integer (Inches Water)
      @orificeBoreDiameter = ko.observable() # float (Inches)

      @compressibilityCorrection = ko.observableArray([ 'None', 'Zf' ])
      @chosenCompressibilityCorrection  = ko.observableArray()

)
