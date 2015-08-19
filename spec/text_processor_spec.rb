RSpec.describe Ursuppe::TextProcessor do
  describe "::new" do
    it "can be initialized" do
      described_class.new
    end
  end

  describe "#text" do
    context "given high temperature" do
      before(:each) { Ursuppe::Measurement.create!(:temperature => 50) }
      before(:each) { Ursuppe::TextComponent.create!(
                          :Sensor_Nr => 1,
                          :Sensor_Min => 40,
                          :Sensor_Max => 100,
                          :Baustein_Typ => "text",
                          :Baustein_Text => "Es ist brüllend heiß!"
      ) }

      it "contains temperature warning" do
        expect(subject.text).to include("Es ist brüllend heiß!")
      end
    end
  end
end
