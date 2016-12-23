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

    NUMBER_OF_COOKIES = 5

    constructor: ->
      config = OPL.OrificeCalculator.Config.Dictionaries
      @FIELDS_FOR_SUGGESTION = ["orificeBoreDiameter", "baseSpecificGravity", "operatingTemperature", "operatingPressure", "differentialPressure", "flowRate"]

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

      @flowRate = ko.observable().extend
        toNumber: true
        number:
          params: true
          message: config.Messages.floatError
        required:
          params: true
          message: config.Messages.flowRateError

      @flowRateInStandardCubicFeetPerHour = ko.pureComputed =>
        return @flowRate() if @selectedFlowUnit() == config.FlowRatePressureUnits.standardCubicFeet && @selectedFlowRateUnit() == config.FlowRateTimeUnits.hour
        flowRate = @flowRate()
        flowRate = OPL.Converter.FlowRate.convert(@selectedFlowUnit(), "Standard Cubic Feet", flowRate) if @selectedFlowUnit() != "Standard Cubic Feet"
        flowRate = OPL.Converter.Rate.convert(@selectedFlowRateUnit(), "Hour", flowRate) if @selectedFlowRateUnit() != "Hour"
        flowRate

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

      @selectedCalculationField = ko.observable "flow rate"
      @isCalculateFlowRate = ko.pureComputed =>
        @selectedCalculationField() == "flow rate"

      @isCalculateDifferentialPressure = ko.pureComputed =>
        @selectedCalculationField() == "differential pressure"

      @selectedCalculationField.subscribe =>
        @flowRate null
        @differentialPressure null

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

      @calculatedFlowRate = ko.pureComputed =>
        flowRate = UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR *
          @velocityOfApproach() * @orificeBoreDiameterInInches() ** 2 * BASE_TEMPERATURE / BASE_PRESSURE *
          ((@operatingPressureInPSI() * BASE_COMPRESSIBILITY * @differentialPressureInInchesWater()) /
          (@baseSpecificGravity() * @compressibilityCorrectionValue() * @operatingTemperatureInRankine())) ** 0.5

        flowRate = OPL.Converter.Rate.convert("Hour", @selectedFlowRateUnit(), flowRate) if @selectedFlowRateUnit() != "Hour"

        # NOTE: The flowRate will be always converted from standardCubicFeet since this is the final units of the calculation
        if @selectedFlowUnit() != config.FlowRatePressureUnits.standardCubicFeet
          flowRate = OPL.Converter.FlowRate.convert(config.FlowRatePressureUnits.standardCubicFeet, @selectedFlowUnit(), flowRate)

        if _.isNaN flowRate
          return undefined
        else
          return _.ceil flowRate, 3

      @calculatedDifferentialPressure = ko.pureComputed =>
        # The results is in the unit of Inches Water
        differentialPressure = (@flowRateInStandardCubicFeetPerHour() / (UNIT_CONVERSION_FACTOR * COEFFICIENT_OF_DISCHARGE * EXPANSION_FACTOR *
        @velocityOfApproach() * @orificeBoreDiameterInInches() ** 2  * BASE_TEMPERATURE / BASE_PRESSURE)) ** 2 *
        (@baseSpecificGravity() * @compressibilityCorrectionValue() * @operatingTemperatureInRankine()) /
        (@operatingPressureInPSI() * BASE_COMPRESSIBILITY )

        if @selectedDifferentialPressureUnit() != "inh2o"
          differentialPressure = OPL.Converter.Pressure.convert("inh2o", @selectedDifferentialPressureUnit(), differentialPressure)

        if _.isNaN differentialPressure
          return undefined
        else
          return _.ceil differentialPressure, 3

      @copyFeedbackActive = ko.observable false
      @copyFeedbackClass = ko.pureComputed =>
        if @copyFeedbackActive()
          return 'bounce-in'
        else
          return 'hidden'

      # Fields to keep the cookies
      @orificeBoreDiameterCookies  = ko.observableArray()
      @baseSpecificGravityCookies  = ko.observableArray()
      @operatingTemperatureCookies = ko.observableArray()
      @operatingPressureCookies    = ko.observableArray()
      @differentialPressureCookies = ko.observableArray()
      @flowRateCookies             = ko.observableArray()

      @calculatedDifferentialPressure.subscribe (differentialPressure) =>
        fields = _.filter @FIELDS_FOR_SUGGESTION, (fields) -> fields != "differentialPressure"
        if differentialPressure
          _.each fields, (field) => @setCookies(field, NUMBER_OF_COOKIES)

      @calculatedFlowRate.subscribe (flowRate) =>
        fields = _.filter @FIELDS_FOR_SUGGESTION, (fields) -> fields != "flowRate"
        if flowRate
          _.each fields, (field) => @setCookies(field, NUMBER_OF_COOKIES)

      _.each @FIELDS_FOR_SUGGESTION, (field) => @initializeFieldWithCookies field

    initializeFieldWithCookies: (variableName) ->
      cookies = @getCookies variableName

      @["#{variableName}Cookies"] _.map cookies, (val) -> { value: val }

    setCookies: (variableName, numberOfCookies) ->
      cookies = @getCookies variableName
      # Only includes value if it is not exist in the current cookies array
      unless _.includes cookies, @[variableName]()
        if cookies?.length >= numberOfCookies
          cookies = cookies.slice(-numberOfCookies + 1)
        cookies.push @[variableName]()
        Cookies.set(variableName, cookies)
        @["#{variableName}Cookies"] _.map cookies, (val) -> { value: val }

    getCookies: (variableName) ->
      cookies = Cookies.get(variableName) || []
      unless _.isEmpty cookies
        cookies = JSON.parse(cookies)

    copyFeedback: =>
      @copyFeedbackActive true
      setTimeout =>
        @copyFeedbackActive false
      , 1000
