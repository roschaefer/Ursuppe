require './app'
require './connection'

crawler = Crawler.new
processor = TextProcessor.new
tweeter = TweetCrawler.new
sender = Sender.new

i = 0

loop do
  i += 1
  puts "iteration #{i}"
  crawler.save_measurement
  processor.save_text("Reportage aus der Ursuppe Nr.#{i}")
  tweeter.save_tweets
  sender.send_commands
  puts "Press Enter"
  gets
end
