module Ursuppe
  class Sender
    def initialize
      RubySpark.configuration do |config|
        config.access_token = "e4d91251296c3d1f3d1814865d76868ab73883c3"
        config.timeout      = 10.seconds # defaults to 30 seconds
      end
      @core = RubySpark::Core.new("DrJakobs_Core_one")
    end

    def send_commands
      Tweet.find_each do |tweet|
        unless tweet.done?
          tweet.commands.each do |command|
            send(command)
            command_record = Command.new({:name => command, :tweet => tweet, :done => false})
            command_record.save
          end
          tweet.done!
        end
      end
    end

    def light_on
      @core.function("led", "on")
    end

    def light_off
      @core.function("led", "off")
    end
  end
end
