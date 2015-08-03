require './connection'

text = ""
Template.all.each do |t|
  fits = true
  fits &= (t.Baustein_von <= 1)
  fits &= (1 < t.Baustein_bis)
  #fits &= (t.Baustein_Zeitvon <= 20)
  #fits &= (20 < t.Baustein_Zeitbis)
  fits &= (t.Sensor_Min < 18)
  fits &= (18 > t.Sensor_Max)
  fits &= (t.Baustein_Typ == "text")
  if fits
    text << t.Baustein_Text
  end
end
puts text.strip
