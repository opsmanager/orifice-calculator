class @OrificeCalculator
  constructor: () ->
    handleCommonKeydown = (event) ->
      if (_.includes([8,9,13,27,37,38,39,40], event.keyCode))
        return
      if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) )
        event.preventDefault()

    ko.bindingHandlers.onlyInteger = {
      init: (element, valueAccessor) ->
        $(element).on('keydown', (event) ->
          handleCommonKeydown(event)
        )
    }

    ko.bindingHandlers.onlyFloat = {
      init: (element, valueAccessor) ->
        $(element).on('keydown', (event) ->
          if (event.keyCode is 190)
            return
          handleCommonKeydown(event)
        )
        $(element).on('keypress', (event) ->
          if (event.keyCode is 46 && element.value.split('.').length is 2)
             event.preventDefault()
        )
    }

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
