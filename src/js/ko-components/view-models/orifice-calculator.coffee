@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  UNIT_CONVERSION_FACTOR = 218.527
  COEFFICIENT_OF_DISCHARGE = 0.6
  EXPANSION_FACTOR         = 1

  # NOTE: The base temperature is in degree rankine
  BASE_TEMPERATURE         = 519.67
  BASE_PRESSURE            = 14.73
  BASE_COMPRESSIBILITY     = 1

  # NOTE: The absolute zero in fahrenheit is -459.67F.
  # This constant is used to convert degree fahrenheit to degree rankine
  ABSOLUTE_ZERO            = 459.67

  constructor: () ->
    @availablePipes = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes
    @selectedPipeDiameter = ko.observable OPL.OrificeCalculator.Config.Dictionaries.AvailablePipes.oneNineInch.value

    @operatingPressure = ko.observable().extend
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

    @baseSpecificGravity = ko.observable().extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.baseSpecificGravityError

    @operatingTemperature = ko.observable().extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operatingTemperatureError

    @operatingTemperatureUnit = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits
    @selectedOperatingTemperatureUnit = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    @differentialPressure = ko.observable().extend
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.differentialPressureError
      digit:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integerError

    @orificeBoreDiameter = ko.observable().extend
      number:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.floatError
      required:
        params: true
        message: OPL.OrificeCalculator.Config.Dictionaries.Messages.orificeBoreDiameterError

    @compressibilityCorrection = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
    @chosenCompressibilityCorrection  = ko.observable OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
    @displayCompressibilityCorrection = ko.computed =>
      @chosenCompressibilityCorrection() != OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
    @compressibilityCorrectionValue = ko.observable(1)

    @betaRatio = ko.computed =>
      _.ceil @orificeBoreDiameter() / @selectedPipeDiameter(), 2

    @velocityOfApproach = ko.computed =>
      _.ceil (1 / Math.sqrt(1 - @betaRatio() ** 4)), 2

    @flowRate = ko.computed =>
      operatingTemperatureInRankine = +@operatingTemperature() + ABSOLUTE_ZERO

      flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR * @velocityOfApproach() * @orificeBoreDiameter() ** 2 * BASE_TEMPERATURE/BASE_PRESSURE \
                 * ((@operatingPressure() * BASE_COMPRESSIBILITY * @differentialPressure()) \
                 / (@baseSpecificGravity() * @compressibilityCorrectionValue() * operatingTemperatureInRankine)) ** 0.5 / 60
      _.ceil flowRate, 3
