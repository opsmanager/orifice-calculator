define 'orifice-calculator-viewmodel', ['knockout', 'lodash', 'knockout.validation', 'orifice-calculator-config'], (ko, _) ->
  @OPL ||= {}
  @OPL.KoComponents ||= {}
  @OPL.KoComponents.ViewModels ||= {}

  class OPL.KoComponents.ViewModels.OrificeCalculator
    UNIT_CONVERSION_FACTOR = 218.527
    COEFFICIENT_OF_DISCHARGE = 0.6
    EXPANSION_FACTOR         = 1

    # NOTE: The base temperature is in degree rankine
    BASE_TEMPERATURE         = 519.67

    # NOTE: The base pressure is in psia
    BASE_PRESSURE            = 14.73
    BASE_COMPRESSIBILITY     = 1

    # NOTE: The absolute zero in fahrenheit is -459.67F.
    # This constant is used to convert degree fahrenheit to degree rankine
    ABSOLUTE_ZERO            = 459.67

    constructor: ->
      config = OPL.OrificeCalculator.Config.Dictionaries

      @availablePipes = ko.observableArray _.values config.AvailablePipes
      @selectedPipeDiameter = ko.observable config.AvailablePipes.oneNineInch.value

      @operatingPressure = ko.observable().extend
        toNumber: true
        required:
          params: true
          message: config.Messages.operatingPressureError
        digit:
          params: true
          message: config.Messages.integerError

      @operatingPressureWarningMessage = ko.pureComputed =>
        switch
          when 200 < @operatingPressure() <= 400 then config.Messages.operatingPressureWarningMayResult
          when 401 <= @operatingPressure() then config.Messages.operatingPressureWarningWillResult

      @operatingPressureRead = ko.observableArray _.values config.OperatingPressureRead
      @selectedOperatingPressureRead = ko.observable config.OperatingPressureRead.gauge

      @operatingPressureUnits = ko.observableArray _.values config.OperatingPressureUnits
      @selectedOperatingPressureUnits = ko.observable config.OperatingPressureUnits.psi

      @baseSpecificGravity = ko.observable().extend
        toNumber: true
        number:
          params: true
          message: config.Messages.floatError
        required:
          params: true
          message: config.Messages.baseSpecificGravityError

      @operatingTemperature = ko.observable().extend
        toNumber: true
        number:
          params: true
          message: config.Messages.floatError
        required:
          params: true
          message: config.Messages.operatingTemperatureError

      @operatingTemperatureUnit = ko.observableArray _.values config.OperatingTemperatureUnits
      @selectedOperatingTemperatureUnit = ko.observable config.OperatingTemperatureUnits.fahrenheit

      @differentialPressure = ko.observable().extend
        toNumber: true
        required:
          params: true
          message: config.Messages.differentialPressureError
        digit:
          params: true
          message: config.Messages.integerError

      @orificeBoreDiameter = ko.observable().extend
        toNumber: true
        number:
          params: true
          message: config.Messages.floatError
        required:
          params: true
          message: config.Messages.orificeBoreDiameterError

      @compressibilityCorrection = ko.observableArray _.values config.CompressibilityCorrection
      @selectedCompressibilityCorrection  = ko.observable config.CompressibilityCorrection.none
      @displayCompressibilityCorrection = ko.computed =>
        @selectedCompressibilityCorrection() != config.CompressibilityCorrection.none

      @compressibilityCorrectionValue = ko.observable()
      @displayCompressibilityCorrection.subscribe (newValue) =>
        if newValue
          @compressibilityCorrectionValue 1
        else
          @compressibilityCorrectionValue undefined


      @betaRatio = ko.computed =>
        betaRatio = _.ceil @orificeBoreDiameter() / @selectedPipeDiameter(), 4
        return undefined if _.isNaN betaRatio
        betaRatio

      @velocityOfApproach = ko.computed =>
        _.ceil (1 / Math.sqrt(1 - @betaRatio() ** 4)), 2

      @availableFlowRateUnits = ko.observableArray _.values config.AvailableFlowRateUnits
      @selectedFlowRateUnit = ko.observable config.AvailableFlowRateUnits.minute

      @flowRate = ko.computed =>
        operatingTemperatureInRankine = @operatingTemperature() + ABSOLUTE_ZERO

        flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR *
          @velocityOfApproach() * @orificeBoreDiameter() ** 2 * BASE_TEMPERATURE / BASE_PRESSURE *
          ((@operatingPressure() * BASE_COMPRESSIBILITY * @differentialPressure()) /
          (@baseSpecificGravity() * @compressibilityCorrectionValue() * operatingTemperatureInRankine)) ** 0.5

        # TODO: Find a better way of doing this. Maybe something related to ko.subscription?
        switch @selectedFlowRateUnit()
          when config.AvailableFlowRateUnits.day then flowRate *= 24
          when config.AvailableFlowRateUnits.minute then flowRate /= 60
          when config.AvailableFlowRateUnits.second then flowRate /= 3600

        operatingTemperatureInRankine = Number(@operatingTemperature()) + ABSOLUTE_ZERO

        if _.isNaN flowRate
          return undefined
        else
          return _.ceil flowRate, 3

      @availableDifferentialPressureUnits = ko.observable _.values config.DifferentialPressureUnits
      @selectedDifferentialPressureUnit = ko.observable config.DifferentialPressureUnits.inchesWater

      @availableBoreDiameterUnits = ko.observable _.values config.OrificeBoreDiameterUnits
      @selectedBoreDiameterUnit = ko.observable config.OrificeBoreDiameterUnits.inches

      @copyFeedbackActive = ko.observable false

      @copyFeedbackClass = ko.pureComputed =>
        if @copyFeedbackActive()
          return 'bounce-in'
        else
          return 'hidden'

    copyFeedback: =>
      @copyFeedbackActive true
      setTimeout =>
        @copyFeedbackActive false
      , 1000
