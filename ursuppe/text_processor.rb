module Ursuppe
  class TextProcessor
    def text
      text = ""
      pre_text = ""
      post_text = ""

      m = Measurement.last
      return "Es liegen noch keine Messdaten vor." if m.nil?

      suitable_text_components = TextComponent.all.select {|tc| tc.fits_to?(m)}
      suitable_text_components.each_with_index do |t, i|
        pre_text << t.Baustein_Vorspann.to_s
        if (i % 3 == 0)
          text << "\n\n####{t.Baustein_Titel}" if t.Baustein_Titel
          text << "\n\n"
        end
        text << t.Baustein_Text.to_s
        post_text << t.Baustein_Abspann.to_s
      end

      not_yet_mentioned_tweets = Tweet.where(:mentioned => false)
      twitter_section = ""
      not_yet_mentioned_tweets.find_each do |tweet|
        tweet.commands.each do |command|
          twitter_section << "\n**Feedback**:\n Vielen Dank an #{tweet.user} für #{command.description} am #{tweet.tweeted_at.strftime("%d.%m.%Y")}!\n"
        end
        tweet.mentioned!
      end


      result = ""
      result << "\n"
      result << "####{pre_text}"
      result << "\n"
      result << "\n"
      result << twitter_section
      result << "\n"
      result << "\n"
      result << "\n"
      result << text
      result << "\n"
      result << "\n"
      result << "\n"
      result << post_text
      result << "\n"

      result.gsub!("%!tag", Ursuppe.day_of_experiment.to_s)
      fill_level = 5
      result.gsub!("%!fuell", fill_level.to_s)
      result.gsub!("%!licht", m.light.to_s)
      result.gsub!("%!temp", m.temperature.to_s)
      result
    end

    def save_text(title)
      now = Time.now
      date = now.strftime("%Y-%m-%d")
      time = now.strftime("%H:%M:%S")
      datetime = "#{date} #{time}"

      result = "---\nlayout: post\ntitle:  #{title}\ndate:   #{datetime}\ncategories: ursuppe\n---"

      result << self.text
      filename = "#{date}-#{time}-#{title}"
      File.open("UrsuppeBlog/_posts/#{filename}.md", 'w') { |file| file.write(result) }
    end
  end
end
