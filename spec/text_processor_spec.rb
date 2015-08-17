require './text_processor'

RSpec.describe TextProcessor do
  describe "::new" do
    it "can be initialized" do
      described_class.new
    end
  end

  describe "#text" do
    context "given high temperature" do
      before(:each) { Measurement.create!(:temperature => 38) }
      it "contains temperature warning" do
        expect(subject.text).to include("Es ist brüllend heiß!")
      end
    end
  end
end
