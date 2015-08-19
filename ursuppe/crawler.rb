module Ursuppe
  class Crawler
    def initialize
      @core = RubySpark::Core.new("DrJakobs_CoreZwo")
    end

    def save_measurement
      attributes = {}
      #attributes[:temperature] = core.variable("Temperatur")
      begin
        attributes[:movement_ground] = @core.variable("movement_gro")
      rescue Net::ReadTimeout
        # don't do anything
      end
      #attributes[:light] = core.variable("Licht")
      m = Measurement.new(attributes)
      m.save
    end
  end
end
