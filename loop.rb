require './app'
require './connection'

spark = Ursuppe::Spark.new
processor = Ursuppe::TextProcessor.new
tweeter = Ursuppe::TweetCrawler.new

i = 0

loop do
  i += 1
  puts "iteration #{i}"
  spark.save_measurement
  processor.save_text("Reportage aus der Ursuppe Nr.#{i}")
  tweeter.save_tweets
  spark.send_commands
  puts "Press Enter"
  gets
end
