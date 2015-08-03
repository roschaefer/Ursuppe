require './connection'

text = ""
pre_text = ""
post_text = ""

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
    pre_text << t.Baustein_Vorspann.to_s
    text << t.Baustein_Text.to_s
    post_text << t.Baustein_Vorspann.to_s
  end
end

text = pre_text + text + post_text
puts text.strip
