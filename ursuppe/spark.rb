module Ursuppe
  class Spark
    def initialize
      RubySpark.configuration do |config|
        config.access_token = secrets['access_token']
        config.timeout      = 10.seconds # defaults to 30 seconds
      end
      @sender_core = RubySpark::Core.new("DrJakobs_Core_one")
      @receiver_core = RubySpark::Core.new("DrJakobs_CoreZwo")
    end

    def secrets
      @secrets ||= YAML::load_file('secrets.yml')
      @secrets["spark"]
    end

    def send_commands
      Command.where(:executed => false).find_each do |command|
        @sender_core.function(command.function, command.parameter)
        command.executed!
      end
    end

    def save_measurement
      attributes = {}
      begin
        attributes[:movement_ground] = @receiver_core.variable("movement_gro")
      rescue Net::ReadTimeout
        # don't do anything
      end
      m = Measurement.new(attributes)
      m.save
    end
  end
end
