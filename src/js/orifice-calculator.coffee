define(['knockout', 'knockout-validation'], (ko) ->
  class OrificeCalculator
    constructor: ->

      @pipeID = ko.observableArray([
        { value: '2.067', name: "2.067'' Sch 40, STD, Sch 40S"  }
        { value: '1.939', name: "1.939'' XS, Sch 80, Sch 80S" } # Default
        { value: '2.157', name: "2.157'' Sch 10, Sch 10S" }
        { value: '2.245', name: "2.245'' Sch 5, Sch 5S" }
        { value: '1.687', name: "1.687'' Sch 160" }
        { value: '1.503', name: "1.503'' XXS" }
      ])

      ko.validation.init()

      @selectedPipeID = ko.observable(@pipeID()[1])
      @operatingPressure = ko.observable('0').extend({
        required: { params: true, message: "Please enter the operating pressure" }
        pattern: {
          params: /^-?\d*$/
          message: 'This should be an integer'
        }
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
      })
      
      @operatingPressureRead = ko.observableArray([ 'Gauge', 'Absolute' ])
      @chosenOperatingPressureRead = ko.observable(@operatingPressureRead()[0])

      @operatingPressureUnits = ko.observableArray([ 'PSI', 'kg/cm2', 'kPa', 'bar', 'mm of Mercury', 'Pa', 'mbar', 'inches of W.C' ])
      @selectedOperatingPressureUnits = ko.observable(@operatingPressureUnits()[0])

      @baseSpecificGravity = ko.observable('0.0').extend({
        required: { params: true, message: "Please enter the base specific gravity" }
      })

      @operatingTemperature = ko.observable('0').extend({
        required: { params: true, message: "Please enter the operating temperature" }
      })

      @operatingTemperatureUnit = ko.observableArray([ 'F', 'C' ])
      @selectedOperatingTemperatureUnit = ko.observable(@operatingTemperatureUnit()[0])

      @differentialPressure = ko.observable('0').extend({
        required: { params: true, message: "Please enter the differential pressure" } 
      }) # Inches Water

      @orificeBoreDiameter = ko.observable('0.0').extend({
        required: {params: true, message: "Please enter the orifice bore diameter" }
      }) # Inches

      # TODO: Set to 0.0 when Zf is selected?
      @compressibilityCorrection = ko.observableArray([ 'None', 'Zf' ])
      @chosenCompressibilityCorrection  = ko.observable(@compressibilityCorrection()[0]) # None
      @compressibilityCorrectionValue = ko.observable('1.0')

      @betaRatio = ko.computed =>
        @orificeBoreDiameter() / @selectedPipeID().value

      @velocityOfApproach = ko.computed =>
        @precision(1 / Math.sqrt( 1 - Math.pow(@betaRatio(), 4) ), 2)

      @flowRateUnit = ko.observableArray(['Minute', 'Hour', 'Day', 'Second'])
      @selectedFlowRateUnit = ko.observable(@flowRateUnit()[1])

      ko.validation.registerExtenders()
      @flowRate = ko.computed =>
        
        coeffDischarge = 0.6
        expansionFactor = 1
        baseTemperature = 519.67 # Tb in Rankine, assumed 60F
        # TODO: make observable return integer instead of string by default?
        operatingTemperatureInRankine = Number(@operatingTemperature()) + 459.67
        basePressure = 14.73 # Pb in psia
        compressibility = 1 # Zb

        flowRate = 218.527 * coeffDischarge * expansionFactor * @velocityOfApproach() * Math.pow(@orificeBoreDiameter(), 2) * (baseTemperature/basePressure) \
                   * Math.pow( (@operatingPressure() * compressibility * @differentialPressure()) \
                   / (@baseSpecificGravity() * @compressibilityCorrectionValue() * operatingTemperatureInRankine), 0.5) / 60 # hour

        switch @selectedFlowRateUnit()
          when 'Day'
            flowRate = flowRate * 24 
          when 'Minute'
            flowRate = flowRate / 60
          when 'Second'
            flowRate = flowRate / 3600
        
        flowRate = @precision(flowRate,3)
        if (flowRate > 0) then flowRate else 0

    precision: (value, precision) ->
      Math.ceil( value * Math.pow(10, precision) ) / Math.pow(10, precision)
)
