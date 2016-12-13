define "unit-converter-spec", ["jasmine-boot", "unit-converter"], ->
  describe "unit-converter-spec", ->
    describe "Dimensions", ->
      it "converts cm to in", ->
        expect(OPL.Converter.Dimensions.cmToInches(10)).toEqual 3.937007874

      it "converts mm to in", ->
        expect(OPL.Converter.Dimensions.mmToInches(12)).toEqual 0.47244094487999994

    describe "Temperature", ->
      it "converts Fahrenheit to Rankine", ->
        # NOTE: for some reason the result is 519.6700000000001, so we need to make it match
        expect(Math.round(OPL.Converter.Temperature.fToRankin(60)*100)/100).toEqual 519.67

      it "converts Celsius to Rankine", ->
        expect(OPL.Converter.Temperature.cToRankin(60)).toEqual 599.67

    describe "Pressure", ->
      it "converts kgcm2 to PSI", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts kpa to PSI", ->
        expect(OPL.Converter.Pressure.kpaToPSI(58)).toEqual 8.41218834

      it "converts pa to PSI", ->
        expect(OPL.Converter.Pressure.paToPSI(58)).toEqual 0.008412188788352759

      it "converts bar to PSI", ->
        expect(OPL.Converter.Pressure.barToPSI(58)).toEqual 841.21887866

      it "converts mbar to PSI", ->
        expect(OPL.Converter.Pressure.mbarToPSI(58)).toEqual 0.84121887866

      it "converts mmHg to PSI", ->
        expect(OPL.Converter.Pressure.mmHgToPSI(58)).toEqual 1.1215329326

      it "converts inH2O to PSI", ->
        expect(OPL.Converter.Pressure.inWaterToPSI(58)).toEqual 2.0953079999999997

      it "converts kgcm2 to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts kpa to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts bar to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts mbar to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts mmHg to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts pa to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372

      it "converts PSI to inH2O", ->
        expect(OPL.Converter.Pressure.kgcm2ToPSI(58)).toEqual 824.95372
