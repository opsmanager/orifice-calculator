class @OrificeCalculator
  constructor: () ->
    @pipeID = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.PipeID)
    @selectedPipeID = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.PipeID['one_nine_inch'])
    @operatingPressure = ko.observable()
    @operatingPressureRead = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead)
    @chosenOperatingPressureRead = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead['gauge'])

    @operatingPressureUnits = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits)
    @selectedOperatingPressureUnits = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits['psi'])

    @baseSpecificGravity = ko.observable() # TODO: float
    @operatingTemperature = ko.observable() # TODO: float
    @operatingTemperatureUnit = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnit)
    @selectedOperatingTemperatureUnit = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnit['fahrenheit'])

    @differentialPressure = ko.observable() # TODO: integer (Inches Water)
    @orificeBoreDiameter = ko.observable() # TODO: float (Inches)

    @compressibilityCorrection = ko.observableArray(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection)
    @chosenCompressibilityCorrection  = ko.observable(OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection['none'])
