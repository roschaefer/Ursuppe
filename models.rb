class  Template < ActiveRecord::Base

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
