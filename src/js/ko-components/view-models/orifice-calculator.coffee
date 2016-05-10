@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  constructor: () ->
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

    @pipeID = ko.observableArray _.map OPL.OrificeCalculator.Config.Dictionaries.PipeID, (pipeName, pipeDiameter) ->
      name: pipeName
      value: pipeDiameter

    @selectedPipeID = ko.observable 1.939

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
    @compressibilityCorrectionValue = ko.observable(1)
    @betaRatio = ko.computed =>
      @orificeBoreDiameter() / @selectedPipeID()

    @velocityOfApproach = ko.computed =>
      Math.ceil((1 / Math.sqrt 1 - @betaRatio() ** 4) * 10 ** 2) / 10 ** 2

    @flowRate = ko.computed =>
      coeffDischarge = 0.6
      expansionFactor = 1
      baseTemperature = 519.67 # Tb in Rankine, assumed 60F
      # TODO: make observable return integer instead of string by default?
      operatingTemperatureInRankine = Number(@operatingTemperature()) + 459.67
      basePressure = 14.73 # Pb in psia
      compressibility = 1 # Zb
      flowRate = 218.527 * coeffDischarge * expansionFactor * @velocityOfApproach() * @orificeBoreDiameter() ** 2 * baseTemperature/basePressure \
                 * ((@operatingPressure() * compressibility * @differentialPressure()) \
                 / (@baseSpecificGravity() * @compressibilityCorrectionValue() * operatingTemperatureInRankine)) ** 0.5 / 60
      Math.ceil(flowRate * 10 ** 3) / 10 ** 3
