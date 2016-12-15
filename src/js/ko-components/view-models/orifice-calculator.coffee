define "orifice-calculator-viewmodel", ["knockout", "lodash", "knockout.validation", "orifice-calculator-config", "unit-converter"], (ko, _) ->
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

    constructor: ->
      config = OPL.OrificeCalculator.Config.Dictionaries

      @availablePipes = ko.observableArray _.values config.AvailablePipes
      @selectedPipeDiameter = ko.observable config.AvailablePipes.oneNineInch.value

      @availablePressureUnits = ko.observable config.PressureUnits

      @operatingPressure = ko.observable().extend
        toNumber: true
        required:
          params: true
          message: config.Messages.operatingPressureError
        digit:
          params: true
          message: config.Messages.integerError

      @operatingPressureRead = ko.observableArray _.values config.OperatingPressureRead
      @selectedOperatingPressureRead = ko.observable config.OperatingPressureRead.gauge
      @selectedOperatingPressureUnit = ko.observable "psi"

      @operatingPressureInPSI = ko.pureComputed =>
        return @operatingPressure() if @selectedOperatingPressureUnit() == "psi"
        OPL.Converter.Pressure.convert(@selectedOperatingPressureUnit(), "psi", @operatingPressure())

      @operatingPressureWarningMessage = ko.pureComputed =>
        switch
          when 200 < @operatingPressureInPSI() <= 400 then config.Messages.operatingPressureWarningMayResult
          when 401 <= @operatingPressureInPSI() then config.Messages.operatingPressureWarningWillResult

      @availableBaseSpecificGravity = ko.observableArray _.values config.BaseSpecificGravity

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

      @selectedDifferentialPressureUnit = ko.observable "inh2o"

      @differentialPressureInInchesWater = ko.pureComputed =>
        return @differentialPressure() if @selectedDifferentialPressureUnit() == "inh2o"
        OPL.Converter.Pressure.convert(@selectedDifferentialPressureUnit(), "inh2o", @differentialPressure())

      @orificeBoreDiameter = ko.observable().extend
        toNumber: true
        number:
          params: true
          message: config.Messages.floatError
        required:
          params: true
          message: config.Messages.orificeBoreDiameterError

      @availableBoreDiameterUnits = ko.observable _.values config.OrificeBoreDiameterUnits
      @selectedBoreDiameterUnit = ko.observable config.OrificeBoreDiameterUnits.inches

      @orificeBoreDiameterInInches = ko.pureComputed =>
        switch @selectedBoreDiameterUnit()
          when config.OrificeBoreDiameterUnits.inches then @orificeBoreDiameter()
          when config.OrificeBoreDiameterUnits.centimeters then OPL.Converter.Dimensions.cmToInches(@orificeBoreDiameter())
          when config.OrificeBoreDiameterUnits.millimeters then OPL.Converter.Dimensions.mmToInches(@orificeBoreDiameter())

      @compressibilityCorrection = ko.observableArray _.values config.CompressibilityCorrection
      @selectedCompressibilityCorrection  = ko.observable config.CompressibilityCorrection.none
      @displayCompressibilityCorrection = ko.computed =>
        @selectedCompressibilityCorrection() != config.CompressibilityCorrection.none

      @compressibilityCorrectionValue = ko.observable(1)
      @displayCompressibilityCorrection.subscribe (isDisplayed) =>
        @compressibilityCorrectionValue 1 unless isDisplayed

      @betaRatio = ko.computed =>
        betaRatio = _.ceil @orificeBoreDiameterInInches() / @selectedPipeDiameter(), 5
        return undefined if _.isNaN betaRatio
        betaRatio

      @velocityOfApproach = ko.computed =>
        _.ceil (1 / Math.sqrt(1 - @betaRatio() ** 4)), 2

      @availableFlowUnits = ko.observableArray _.values config.FlowRatePressureUnits
      @selectedFlowUnit = ko.observable config.FlowRatePressureUnits.standardCubicFeet

      @availableFlowRateUnits = ko.observableArray _.values config.FlowRateTimeUnits
      @selectedFlowRateUnit = ko.observable config.FlowRateTimeUnits.hour

      @operatingTemperatureInRankine = ko.pureComputed =>
        switch @selectedOperatingTemperatureUnit()
          when config.OperatingTemperatureUnits.fahrenheit then OPL.Converter.Temperature.fToRankin(@operatingTemperature())
          when config.OperatingTemperatureUnits.celsius then OPL.Converter.Temperature.cToRankin(@operatingTemperature())

      @flowRate = ko.pureComputed =>
        flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR *
          @velocityOfApproach() * @orificeBoreDiameterInInches() ** 2 * BASE_TEMPERATURE / BASE_PRESSURE *
          ((@operatingPressureInPSI() * BASE_COMPRESSIBILITY * @differentialPressureInInchesWater()) /
          (@baseSpecificGravity() * @compressibilityCorrectionValue() * @operatingTemperatureInRankine())) ** 0.5

        # TODO: Find a better way of doing this. Maybe something related to ko.subscription?
        switch @selectedFlowRateUnit()
          when config.FlowRateTimeUnits.day then flowRate *= 24
          when config.FlowRateTimeUnits.minute then flowRate /= 60
          when config.FlowRateTimeUnits.second then flowRate /= 3600

        # NOTE: The flowRate will be always converted from standardCubicFeet since this is the final units of the calculation
        if @selectedFlowUnit() != config.FlowRatePressureUnits.standardCubicFeet
          flowRate = OPL.Converter.FlowRate.convert(config.FlowRatePressureUnits.standardCubicFeet, @selectedFlowUnit(), flowRate)

        if _.isNaN flowRate
          return undefined
        else
          return _.ceil flowRate, 3

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
