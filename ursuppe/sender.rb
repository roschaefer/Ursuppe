module Ursuppe
  class Sender
    def initialize
      RubySpark.configuration do |config|
        config.access_token = secrets['access_token']
        config.timeout      = 10.seconds # defaults to 30 seconds
      end
      @core = RubySpark::Core.new("DrJakobs_Core_one")
    end

    def secrets
      @secrets ||= YAML::load_file('secrets.yml')
      @secrets["spark"]
    end

    def send_commands
      Command.where(:executed => false).find_each do |command|
        @core.function(command.function, command.parameter)
        command.executed!
      end
    end

  end
end
