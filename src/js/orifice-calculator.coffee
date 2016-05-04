define(['knockout'], (ko) ->
  class OrificeCalculator
    constructor: ->
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

      ko.extenders.required = (target, overrideMessage) ->
        target.hasError = ko.observable()
        target.validationMessage = ko.observable()
        validate = (newValue) ->
          target.hasError((newValue) -> 
            _.empty(newValue)
          )
          target.validationMessage((newValue) ->
           if(_.empty(newValue))
             return ""
           else
             return overrideMessage || "This field is required"
          )
        validate(target())
        target.subscribe(validate)

      @pipeID = ko.observableArray([
               "2.067'' Sch 40, STD, Sch 40S"
               "1.939'' XS, Sch 80, Sch 80S" # Default
               "2.157'' Sch 10, Sch 10S"
               "2.245'' Sch 5, Sch 5S"
               "1.687'' Sch 160"
               "1.503'' XXS"
              ])

      @selectedPipeID = ko.observable(@pipeID()[1])
      
      @operatingPressure = ko.observable().extend({ required: "Please enter the operating pressure" })

      @operatingPressureRead = ko.observableArray([ 'Gauge', 'Absolute' ])
      @chosenOperatingPressureRead = ko.observable(@operatingPressureRead()[0])
      
      @operatingPressureUnits = ko.observableArray([ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ])
      @selectedOperatingPressureUnits = ko.observable(@operatingPressureUnits()[0])

      @baseSpecificGravity = ko.observable() # TODO: float
      @operatingTemperature = ko.observable() # TODO: float
      @operatingTemperatureUnit = ko.observableArray([ 'F', 'C' ])
      @selectedOperatingTemperatureUnit = ko.observable(@operatingTemperatureUnit()[0])

      @differentialPressure = ko.observable() # TODO: integer (Inches Water)
      @orificeBoreDiameter = ko.observable() # TODO: float (Inches)

      @compressibilityCorrection = ko.observableArray([ 'None', 'Zf' ])
      @chosenCompressibilityCorrection  = ko.observable(@compressibilityCorrection()[0])


)
