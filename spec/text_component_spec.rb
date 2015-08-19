RSpec.describe Ursuppe::TextComponent do
  describe "fits_to?" do
    # Measurements
    let(:high_temperature) { Ursuppe::Measurement.create!(:temperature => 30) }
    let(:room_temperature) { Ursuppe::Measurement.create!(:temperature => 23) }
    let(:low_temperature)  { Ursuppe::Measurement.create!(:temperature => 10) }
    let(:movement_ground)  { Ursuppe::Measurement.create!(:movement_ground => 1) }
    let(:bright_light)     { Ursuppe::Measurement.create!(:light => 10) }
    let(:darkness)         { Ursuppe::Measurement.create!(:light => 0) }


    # TextComponents
    let(:too_hot)            { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Min => 30) }
    let(:comfortable)        { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Min => 20, :Sensor_Max => 26) }
    let(:too_cold)           { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Max => 19) }

    let(:early_fever)        { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Min => 30, :Baustein_bis => 10) }
    let(:late_ice_age)       { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Max => 20, :Baustein_von => 30) }

    let(:cold_evening)       { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Max => 20, :Baustein_Zeitvon => 18, :Baustein_Zeitbis => 22) }
    let(:hot_noon)           { Ursuppe::TextComponent.create!(:Sensor_Nr => 1, :Sensor_Min => 30, :Baustein_Zeitvon => 11, :Baustein_Zeitbis => 14) }

    let(:morning_riot)       { Ursuppe::TextComponent.create!(:Sensor_Nr => 3, :Sensor_Min => 1, :Baustein_Zeitvon => 6, :Baustein_Zeitbis => 10) }
    let(:nightly_brightness) { Ursuppe::TextComponent.create!(:Sensor_Nr => 2, :Sensor_Max => 5, :Baustein_Zeitvon => 0, :Baustein_Zeitbis => 5) }

    specify { expect(too_hot).to fit(high_temperature) }
    specify { expect(too_hot).not_to fit(low_temperature) }
    specify { expect(too_cold).to fit(low_temperature) }
    specify { expect(comfortable).to fit(room_temperature) }

    context "day of experiment is 1st of August" do
      before(:each) { stub_const("Ursuppe::START_OF_EXPERIMENT", Time.new(2015,8,01)) }

      context "and it's an early stage" do
        around(:each) do |example|
          Timecop.freeze(Date.parse('2015-08-03')) { example.run }
        end

        specify { expect(late_ice_age).not_to fit(low_temperature) }
        specify { expect(late_ice_age).not_to fit(room_temperature) }
        specify { expect(late_ice_age).not_to fit(high_temperature) }
        specify { expect(early_fever).not_to fit(low_temperature) }
        specify { expect(early_fever).not_to fit(room_temperature) }
        specify { expect(early_fever).to fit(high_temperature) }
      end

      context "the experiment has advanced" do
        around(:each) do |example|
          Timecop.freeze(Date.parse('2015-09-30')) { example.run }
        end

        specify { expect(late_ice_age).to fit(low_temperature) }
        specify { expect(late_ice_age).not_to fit(room_temperature) }
        specify { expect(late_ice_age).not_to fit(high_temperature) }
        specify { expect(early_fever).not_to fit(low_temperature) }
        specify { expect(early_fever).not_to fit(room_temperature) }
        specify { expect(early_fever).not_to fit(high_temperature) }
      end
    end
  end
end
