define(['knockout'], (ko) ->
  class OrificeCalculator
    constructor: ->
      @bindings()
      @extenders()

      @pipeID = ko.observableArray([
        { value: '2.067', name: "2.067'' Sch 40, STD, Sch 40S"  }
        { value: '1.939', name: "1.939'' XS, Sch 80, Sch 80S" } # Default
        { value: '2.157', name: "2.157'' Sch 10, Sch 10S" }
        { value: '2.245', name: "2.245'' Sch 5, Sch 5S" }
        { value: '1.687', name: "1.687'' Sch 160" }
        { value: '1.503', name: "1.503'' XXS" }
      ])

      @selectedPipeID = ko.observable(@pipeID()[1])

      @operatingPressure = ko.observable('0').extend({ required: "Please enter the operating pressure", validatePressure: true })

      @operatingPressureRead = ko.observableArray([ 'Gauge', 'Absolute' ])
      @chosenOperatingPressureRead = ko.observable(@operatingPressureRead()[0])

      @operatingPressureUnits = ko.observableArray([ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ])
      @selectedOperatingPressureUnits = ko.observable(@operatingPressureUnits()[0])

      @baseSpecificGravity = ko.observable('0.0').extend({ required: "Please enter the base specific gravity" })

      @operatingTemperature = ko.observable('0').extend({ required: "Please enter the operating temperature" })

      @operatingTemperatureUnit = ko.observableArray([ 'F', 'C' ])
      @selectedOperatingTemperatureUnit = ko.observable(@operatingTemperatureUnit()[0])

      @differentialPressure = ko.observable('0').extend({ required: "Please enter the differential pressure" }) # Inches Water

      @orificeBoreDiameter = ko.observable('0.0').extend({ required: "Please enter the orifice bore diameter" }) # Inches

      # TODO: Set to 0.0 when Zf is selected?
      @compressibilityCorrection = ko.observableArray([ 'None', 'Zf' ])
      @chosenCompressibilityCorrection  = ko.observable(@compressibilityCorrection()[0]) # None
      @compressibilityCorrectionValue = ko.observable('1.0')

      @betaRatio = ko.computed(() =>
        @orificeBoreDiameter() / @selectedPipeID()
      )

      @velocityOfApproach = ko.computed(() =>
        @precision(1 / Math.sqrt( 1 - Math.pow(@betaRatio(), 4) ), 2)
      )

      @flowRate = ko.computed(() =>
        coeffDischarge = 0.6
        expansionFactor = 1
        baseTemperature = 519.67 # Tb in Rankine, assumed 60F
        # TODO: make observable return integer instead of string by default?
        operatingTemperatureInRankine = Number(@operatingTemperature()) + 459.67
        basePressure = 14.73 # Pb in psia
        compressibility = 1 # Zb
        flowRate = 218.527 * coeffDischarge * expansionFactor * @velocityOfApproach() * Math.pow(@orificeBoreDiameter(), 2) * (baseTemperature/basePressure) \
                   * Math.pow( (@operatingPressure() * compressibility * @differentialPressure()) \
                   / (@baseSpecificGravity() * @compressibilityCorrectionValue() * operatingTemperatureInRankine), 0.5) / 60
        flowRate = @precision(flowRate,3)

        if (flowRate > 0) then flowRate else 0
      )

      @flowRateUnit = ko.observableArray(['Minute', 'Hour', 'Day', 'Second'])
      @selectedFlowRateUnit = ko.observable(@flowRateUnit()[1])

    precision: (value, precision) ->
      Math.ceil( value * Math.pow(10, precision) ) / Math.pow(10, precision)

    extenders: () ->
      ko.extenders.required = (target, overrideMessage) ->
        target.hasError = ko.observable()
        target.validationMessage = ko.observable()

        validate = (newValue) ->
          if newValue
            target.hasError(false)
            target.validationMessage("")
          else
            target.hasError(true)
            target.validationMessage(overrideMessage || "This field is required")
        validate(target())
        target.subscribe(validate)
        target

      ko.extenders.validatePressure = (target) ->
        target.status = ko.observable('')
        target.statusMessage = ko.observable()
        target.showMessage = ko.observable()

        validPressure = (value) ->
          if value > 200 && value < 401
            target.status('warning')
            target.showMessage(true)
            target.statusMessage("At this pressure, no compressibility correction may result in erroneous computations")
          else if value > 400
            target.status('error')
            target.showMessage(true)
            target.statusMessage("At this pressure, no compressibility correction will result in erroneous computations")
          else
            target.showMessage(false)

        validPressure(target())
        target.subscribe(validPressure)
        target

    bindings: () ->
      #TODO: Replace this with https://github.com/Knockout-Contrib/Knockout-Validation
      ko.bindingHandlers.onlyInteger = {
        init: (element, valueAccessor) ->
          $(element).on('keydown', (event) ->
            @handleCommonKeydown(event)
          )
      }

      ko.bindingHandlers.onlyFloat = {
        init: (element, valueAccessor) ->
          $(element).on('keydown', (event) ->
            if (event.keyCode is 190)
              return
            @handleCommonKeydown(event)
          )
          $(element).on('keypress', (event) ->
            if (event.keyCode is 46 && element.value.split('.').length is 2)
               event.preventDefault()
          )
      }

      ko.bindingHandlers.copyToClipboard = {
        init: (element) ->
          $(element).on('click', (event) ->
            temp = document.createElement('input')
            temp.setAttribute('value', element.innerHTML)
            document.body.appendChild(temp)
            temp.select()
            document.execCommand('copy')
            document.body.removeChild(temp)
          )
      }

    handleCommonKeydown: (event) ->
      #TODO: To write spec for handleCommonKeydown
        if (_.includes([8,9,13,27,37,38,39,40], event.keyCode))
          return
        if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) )
          event.preventDefault()

    copyFlowRate: () ->
      console.log('click!')

)
