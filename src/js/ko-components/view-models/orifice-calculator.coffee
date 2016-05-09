@OPL ||= {}
@OPL.KoComponents ||= {}
@OPL.KoComponents.ViewModels ||= {}

class OPL.KoComponents.ViewModels.OrificeCalculator
  constructor: () ->
    @pipeID = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.PipeID
    @selectedPipeID = ko.observable OPL.OrificeCalculator.Config.Dictionaries.PipeID.one_nine_inch
    @operatingPressure = ko.observable(0).extend {
        required: { params: true, message: "Please enter the operating pressure" }
        digit: { params: true, message: 'Please enter an integer' }
      }

    @operatingPressureRead = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead
    @chosenOperatingPressureRead = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureRead.gauge

    @operatingPressureUnits = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits
    @selectedOperatingPressureUnits = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingPressureUnits.psi

    @baseSpecificGravity = ko.observable('0.0').extend {
      number: { params: true, message: 'Please enter a float' }
      required: { params: true, message: "Please enter the base specific gravity" }
    }

    @operatingTemperature = ko.observable('0.0').extend {
      number: { params: true, message: 'Please enter a float' }
      required: { params: true, message: "Please enter the operating temperature" }
    }

    @operatingTemperatureUnit = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits
    @selectedOperatingTemperatureUnit = ko.observable OPL.OrificeCalculator.Config.Dictionaries.OperatingTemperatureUnits.fahrenheit

    @differentialPressure = ko.observable(0).extend {
        required: { params: true, message: "Please enter the differential pressure" }
        digit: { params: true, message: 'Please enter an integer' }
    }

    @orificeBoreDiameter = ko.observable('0.0').extend {
      number: { params: true, message: 'Please enter a float' }
      required: { params: true, message: "Please enter the orifice bore diameter" }
    }

    @compressibilityCorrection = ko.observableArray _.values OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection
    @chosenCompressibilityCorrection  = ko.observable OPL.OrificeCalculator.Config.Dictionaries.CompressibilityCorrection.none
