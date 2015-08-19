module Ursuppe
  class  TextComponent < ActiveRecord::Base
    MAPPING_SENSOR_NR = {
      1 => :temperature,
      2 => :light,
      3 => :movement_ground
    }

    def fits_to?(measurement)
      fits = true
      attribute_name = MAPPING_SENSOR_NR[self.Sensor_Nr]
      if attribute_name # if this is not nil, we check the sensor data
        value = measurement.send(attribute_name)

        # if we have measured nil, we assume the text component doesn't fit
        return false if value.nil?

        if self.Sensor_Min
          fits &= self.Sensor_Min <= value 
        end
        if self.Sensor_Max
          fits &= self.Sensor_Max >= value
        end
      end

      if self.Baustein_von
        fits &= self.Baustein_von <= Ursuppe.day_of_experiment
      end
      if self.Baustein_bis
        fits &= self.Baustein_bis >= Ursuppe.day_of_experiment
      end


      fits &= self.Baustein_Typ == 'text'

      fits
    end
  end

  class  Measurement < ActiveRecord::Base

  end


  class  Tweet < ActiveRecord::Base
    validates :twitter_id, :uniqueness => :true
    after_create :create_commands
    has_many :commands

    def done!
      self.done = true
      self.save!
    end

    def create_commands
      hashtag_mapping = {
        "#lichtan" => { :function => :led, :parameter => :on, :description => "Einschalten des Lichts"},
        "#lichtaus" => { :function => :led, :parameter => :off, :description => "Ausschalten des Lichts"}
      }

      hashtag_mapping.each do |hashtag, attributes|
        if text.include?(hashtag)
          Command.create(attributes.merge(:tweet_id => self.id)) if text.include?(hashtag)
        end
      end
    end
  end


  class Command < ActiveRecord::Base
    belongs_to :tweet
  end
end
