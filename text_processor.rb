require './connection'
class TextProcessor
  def save_text(title)
    text = ""
    pre_text = ""
    post_text = ""

    now = Time.now

    date = now.strftime("%Y-%m-%d")
    time = now.strftime("%H:%M:%S")
    filename = "#{date}-#{title}"
    datetime = "#{date} #{time}"


    start_day = Time.new(2015, 07, 31)
    day_of_experiment = ((now - start_day)/1.day).to_i
    fill_level = 5
    temperature = 21
    light = 5


    m = Measurement.last
    return if m.nil?
    sended_commands = Command.where(:done => false)

    Template.all.each do |t|
      fits = true
      fits &= (t.Baustein_von <= day_of_experiment)
      fits &= (day_of_experiment <= t.Baustein_bis)
      #fits &= (t.Baustein_Zeitvon <= 20)
      #fits &= (20 < t.Baustein_Zeitbis)
      fits &= (t.Baustein_Typ == "text")

      unless t.Sensor_Nr == 0
        mapping = {
          1=> :temperature,
          2=> :light,
          3=> :movement_ground
        }
        sensor_attribute = mapping[t.Sensor_Nr]
        value = m.send(sensor_attribute) if sensor_attribute
        if value
          fits &= (t.Sensor_Min <= value)
          fits &= (value <= t.Sensor_Max)
        end
      end

      if fits
        pre_text << t.Baustein_Vorspann.to_s
        text << t.Baustein_Text.to_s
        post_text << t.Baustein_Abspann.to_s
      end
    end

    command_section = ""
    sended_commands.find_each do |command|
      mapping = {
        "light_on" => "Einschalten",
        "light_off" => "Ausschalten"
      }
      what = mapping[command.name]
      command_section << "\n##Feedback\nVielen dank an #{command.tweet.user} für das #{what} des Lichts, am #{command.tweet.tweeted_at.strftime("%d.%m.%Y")}!\n"
      command.done = true
      command.save
    end


    result =
      %{---
layout: post
title:  "#{title}"
date:   #{datetime}
categories: ursuppe
---
    }

    result << "\n"
    result << command_section
    result << "\n"
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

    result.gsub!("%!tag", day_of_experiment.to_s)
    result.gsub!("%!fuell", fill_level.to_s)
    result.gsub!("%!licht", light.to_s)
    result.gsub!("%!temp", temperature.to_s)

    File.open("UrsuppeBlog/_posts/#{filename}.md", 'w') { |file| file.write(result) }
  end
end

