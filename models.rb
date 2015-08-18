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
      # we assume that we have no nil values in measurements
      if self.Sensor_Min
        fits &= self.Sensor_Min <= value 
      end
      if self.Sensor_Max
        fits &= self.Sensor_Max >= value
      end
    end
    fits
  end
end

class  Measurement < ActiveRecord::Base

end


class  Tweet < ActiveRecord::Base
  validates :twitter_id, :uniqueness => :true
  def commands
    commands = []
    hashtag_mapping = {
      "#lichtan" => :light_on,
      "#lichtaus" => :light_off
    }
    hashtag_mapping.each do |key,command|
      if text.include?(key)
        commands << command
      end
    end
    commands
  end

  def done!
    self.done = true
    self.save!
  end
end


class Command < ActiveRecord::Base
  belongs_to :tweet
end
