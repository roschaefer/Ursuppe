RSpec.describe Ursuppe::Tweet do
  describe "#save" do
    context "creates a command for certain hashtags in the text" do
      let(:no_hashtag)        { described_class.create(:text => "I am a Tweet") }
      let(:light_on)          { described_class.create(:text => "Mach das #lichtan !") }
      let(:light_on_and_off)  { described_class.create(:text => "Ständig geht das #lichtan, #lichtaus und wieder #lichtan") }

      specify { expect { no_hashtag       }.not_to change { Ursuppe::Command.count } }
      specify { expect { light_on         }.to change     { Ursuppe::Command.count }.from(0).to(1) }
      specify { expect { light_on_and_off }.to change     { Ursuppe::Command.count }.from(0).to(2) }


      specify { expect(light_on.commands.first.function).to eq "led" }
      specify { expect(light_on.commands.first.parameter).to eq "on" }

      specify { expect(light_on_and_off.commands).to have_exactly(2).items }
    end
  end
end
