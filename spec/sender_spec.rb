RSpec.describe Ursuppe::Sender do
  describe "#send_commands" do
    before(:each) { subject.instance_variable_set(:@core, core) }
    let(:core) { RubySpark::Core.new("doesn't matter") }


    it "sends commands to core" do
      Ursuppe::Command.create(:executed => false, :function => "func", :parameter => "param")
      expect(core).to receive(:function).with("func", "param")
      subject.send_commands
    end

    it "ignores executed commands" do
      Ursuppe::Command.create(:executed => true)
      expect(core).not_to receive(:function)
      subject.send_commands
    end
  end

  describe "#secrets" do
    specify{ expect(subject.secrets['access_token']).not_to eq "ACCESS_TOKEN" }
  end
end
