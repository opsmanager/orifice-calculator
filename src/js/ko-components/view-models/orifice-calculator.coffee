@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  constructor: () ->
    @pipeID = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.PipeID
    @selectedPipeID = ko.observable OPL.OrificeCalculator.Config.Dictionaries.PipeID.oneNineInch
    @operatingPressure = ko.observable(0).extend
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureError
      digit:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integerError

    @operatingPressureWarningMessage = ko.pureComputed =>
      switch
        when 200 < @operatingPressure() <= 400 then OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningMayResult
        when 401 <= @operatingPressure() then OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingPressureWarningWillResult

    @operatingPressureRead = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead
    @chosenOperatingPressureRead = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

    @operatingPressureUnits = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits
    @selectedOperatingPressureUnits = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits.psi

    @baseSpecificGravity = ko.observable(0).extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.baseSpecificGravityError

    @operatingTemperature = ko.observable(0).extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingTemperatureError

    @operatingTemperatureUnit = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits
    @selectedOperatingTemperatureUnit = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    @differentialPressure = ko.observable(0).extend
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.differentialPressureError
      digit:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integerError

    @orificeBoreDiameter = ko.observable(0).extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.orificeBoreDiameterError

    @compressibilityCorrection = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
    @chosenCompressibilityCorrection  = ko.observable OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
