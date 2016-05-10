@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  constructor: () ->
    @pipeID = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.PipeID
    @selectedPipeID = ko.observable OPL.OrificeCalculator.Config.Dictionaries.PipeID.one_nine_inch
    @operatingPressure = ko.observable(0).extend {
      required: { params: true, message: 'Please enter the operating pressure' }
      digit: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integer }
      validation: [
        {
          validator: (val) ->
            !(val > 200 and val < 401)
          message: OPL.OrificeCalculator.Config.Dictionaries.Messages.warning
          messageClass: 'warning'
        }
        {
          validator: (val) ->
            !(val > 400)
          message: OPL.OrificeCalculator.Config.Dictionaries.Messages.error
          messageClass: 'error'
        }
      ]
    }

    @operatingPressureRead = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead
    @chosenOperatingPressureRead = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

    @operatingPressureUnits = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits
    @selectedOperatingPressureUnits = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits.psi

    @baseSpecificGravity = ko.observable(0).extend {
      number: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.float }
      required: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.base_specific_gravity }
    }

    @operatingTemperature = ko.observable(0).extend {
      number: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.float }
      required: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.operating_temperature }
    }

    @operatingTemperatureUnit = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits
    @selectedOperatingTemperatureUnit = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    @differentialPressure = ko.observable(0).extend {
      required: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.differential_pressure }
      digit: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.integer }
    }

    @orificeBoreDiameter = ko.observable(0).extend {
      number: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.float }
      required: { params: true, message: OPL.OrificeCalculator.Config.Dictionaries.Messages.orifice_bore_diameter }
    }

    @compressibilityCorrection = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
    @chosenCompressibilityCorrection  = ko.observable OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
