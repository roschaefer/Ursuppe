RSpec.describe Ursuppe::Spark do
  describe "#send_commands" do
    let(:sender_core) { subject.instance_variable_get(:@sender_core) }

    it "sends commands to core" do
      Ursuppe::Command.create(:executed => false, :function => "func", :parameter => "param")
      expect(sender_core).to receive(:function).with("func", "param")
      subject.send_commands
    end

    it "ignores executed commands" do
      Ursuppe::Command.create(:executed => true)
      expect(sender_core).not_to receive(:function)
      subject.send_commands
    end
  end

  describe "#save_measurements" do
    let(:receiver_core) { subject.instance_variable_get(:@receiver_core) }

    context "gets sensor data from the core" do
      before(:each) do
        allow(receiver_core).to receive(:variable).with("movement_gro") { 1 }
        #allow(receiver_core).to receive(:variable).with("light") { 10 }
        #allow(receiver_core).to receive(:variable).with("temperature") { 23 }
        expect{subject.save_measurements}.to change{Ursuppe::Measurement.count}.from(0).to(1) 
      end

      context "the measurement" do
        let(:measurement) { Ursuppe::Measurement.first }
        specify { expect(measurement.movement_ground).to eq 1 }
      end
    end
  end

  describe "#secrets" do
    specify{ expect(subject.secrets['access_token']).not_to eq "ACCESS_TOKEN" }
  end
end
