require './connection'

class Crawler
  def initialize
    @core = RubySpark::Core.new("DrJakobs_CoreZwo")
  end

  def save_measurement
    attributes = {}
    #attributes[:temperature] = core.variable("Temperatur")
    attributes[:movement_ground] = @core.variable("movement_gro")
    #attributes[:light] = core.variable("Licht")
    m = Measurement.new(attributes)
    m.save
  end
end

