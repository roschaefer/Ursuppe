require 'active_record'
require 'sqlite3'
require 'logger'
require 'pry'
require 'csv'
require 'ruby_spark'
require 'twitter'

ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

class  Template < ActiveRecord::Base

end

class  Measurement < ActiveRecord::Base

end

class  Tweet < ActiveRecord::Base
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
  end
end

