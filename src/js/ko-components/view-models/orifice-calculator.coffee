@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  constructor: () ->
    ko.validation.init()
    @pipeID = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.PipeID
    @selectedPipeID = ko.observable OPL.OrificeCalculator.Config.Dictionaries.PipeID.one_nine_inch
    @operatingPressure = ko.observable(0).extend {
        required: { params: true, message: "Please enter the operating pressure" }
        digit: { params: true, message: 'Please enter an integer' }
        validation: [
          {
            validator: (val) ->
              val <= 200 or val >= 400
            message: 'At this pressure, no compressibility correction may result in erroneous computations'
            messageClass: 'warning'
          }
          {
            validator: (val) ->
              val < 400
            message: 'At this pressure, no compressibility correction will result in erroneous computations'
            messageClass: 'error'
          }
        ]
      }
    @operatingPressureRead = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead
    @chosenOperatingPressureRead = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

    @operatingPressureUnits = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits
    @selectedOperatingPressureUnits = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits.psi

    @baseSpecificGravity = ko.observable('0.0') # TODO: float
    @operatingTemperature = ko.observable('0.0') # TODO: float
    @operatingTemperatureUnit = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits
    @selectedOperatingTemperatureUnit = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    @differentialPressure = ko.observable(0) # TODO: integer (Inches Water)
    @orificeBoreDiameter = ko.observable('0.0') # TODO: float (Inches)

    @compressibilityCorrection = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
    @chosenCompressibilityCorrection  = ko.observable OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
