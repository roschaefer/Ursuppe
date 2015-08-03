require './connection'

text = ""
pre_text = ""
post_text = ""

now = DateTime.now

title = "First"
date = now.strftime("%Y-%m-%d")
time = now.strftime("%H:%M:%S")
filename = "#{date}-#{title}"
datetime = "#{date} #{time}"

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


result =
%{---
layout: post
title:  "#{title}"
date:   #{datetime}
categories: ursuppe
---
}

result << "##Vorspann"
result << "\n"
result << "\n"
result << pre_text
result << "\n"
result << "\n"
result << "##Haupttext"
result << "\n"
result << "\n"
result << text
result << "\n"
result << "\n"
result << "##Nachspann"
result << "\n"
result << "\n"
result << post_text
result << "\n"

File.open("UrsuppeBlog/_posts/#{filename}.md", 'w') { |file| file.write(result) }
