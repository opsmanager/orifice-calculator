class @OrificeCalculator
  constructor: () ->
    @pipeID = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.PipeID)
    @selectedPipeID = ko.observable(@pipeID()[1])
    @operatingPressure = ko.observable()
    @operatingPressureRead = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead)
    @chosenOperatingPressureRead = ko.observable(@operatingPressureRead()[0])

    @operatingPressureUnits = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits)
    @selectedOperatingPressureUnits = ko.observable(@operatingPressureUnits()[0])

    @baseSpecificGravity = ko.observable() # TODO: float
    @operatingTemperature = ko.observable() # TODO: float
    @operatingTemperatureUnit = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnit)
    @selectedOperatingTemperatureUnit = ko.observable(@operatingTemperatureUnit()[0])

    @differentialPressure = ko.observable() # TODO: integer (Inches Water)
    @orificeBoreDiameter = ko.observable() # TODO: float (Inches)

    @compressibilityCorrection = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection)
    @chosenCompressibilityCorrection  = ko.observable(@compressibilityCorrection()[0])
