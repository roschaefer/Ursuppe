RSpec.describe Ursuppe::TextProcessor do
  describe "::new" do
    it "can be initialized" do
      described_class.new
    end
  end

  describe "#text" do
    before(:each) do
      Ursuppe::TextComponent.create!( :Sensor_Nr => 1, :Sensor_Min => 40, :Baustein_Typ => "text", :Baustein_Text => "Es ist brüllend heiß!")
      Ursuppe::TextComponent.create!( :Sensor_Nr => 1, :Sensor_Max => 10, :Baustein_Typ => "text", :Baustein_Text => "Die Triops erfrieren!!")
      Ursuppe::TextComponent.create!( :Baustein_Typ => "text", :Baustein_Text => "Es ist der %!tag. Tag des Experiments.")
      Ursuppe::TextComponent.create!( :Baustein_Typ => "text", :Baustein_Text => "Der Füllstand liegt bei %!fuell.")
      Ursuppe::TextComponent.create!( :Baustein_Typ => "text", :Baustein_Text => "Es ist %!temp°C warm.")
      Ursuppe::TextComponent.create!( :Baustein_Typ => "text", :Baustein_Text => "Die aktuelle Helligkeitsstufe liegt bei %!licht.")
    end

    it "informs about missing measurements" do
      expect(subject.text).to eq "Es liegen noch keine Messdaten vor."
    end

    context "string-replace variables in text" do
      it "for the day of the experiment" do
        Timecop.freeze(Time.new(2015,03,02)) do
          Ursuppe::Measurement.create() # dummy measurement
          stub_const("Ursuppe::START_OF_EXPERIMENT", Time.new(2015,03,01))
          expect(subject.text).to include("Es ist der 2. Tag des Experiments.")
        end
      end

      it "for temperature" do
        Ursuppe::Measurement.create!(:temperature => 431)
        expect(subject.text).to include("Es ist 431°C warm.")
      end

      it "for filling level" do
        Ursuppe::Measurement.create!(:light => 23)
        expect(subject.text).to include("Die aktuelle Helligkeitsstufe liegt bei 23.")
      end

      it "for light", :pending => "Missing migration for filling level, currently hard coded filling level of 5" do
        Ursuppe::Measurement.create!(:filling_level => 57)
        expect(subject.text).to include("Der Füllstand liegt bei 57.")
      end
    end

    context "extreme temperature" do

      it "triggers high temperature warning" do
        Ursuppe::Measurement.create!(:temperature => 50)
        expect(subject.text).to include("Es ist brüllend heiß!")
        expect(subject.text).not_to include("Die Triops erfrieren!")
      end

      it "triggers low temperature warning" do
        Ursuppe::Measurement.create!(:temperature => 5)
        expect(subject.text).not_to include("Es ist brüllend heiß!")
        expect(subject.text).to include("Die Triops erfrieren!")
      end
    end
  end
end
