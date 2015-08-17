require './text_processor'

RSpec.describe TextProcessor do
  describe "::new" do
    it "can be initialized" do
      described_class.new
    end
  end
end
