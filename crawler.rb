require './connection'


RubySpark.configuration do |config|
  config.access_token = "e4d91251296c3d1f3d1814865d76868ab73883c3"
  config.timeout      = 10.seconds # defaults to 30 seconds
end
core = RubySpark::Core.new("DrJakobs_CoreZwo")
attributes = {}
#attributes[:temperature] = core.variable("Temperatur")
attributes[:movement_ground] = core.variable("movement_gro")
#attributes[:light] = core.variable("Licht")
m = Measurement.new(attributes)
m.save
binding.pry
