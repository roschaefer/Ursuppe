require './connection'
require './crawler'
require './text_processor'
require './tweet_crawler'
require './sender'

crawler = Crawler.new
processor = TextProcessor.new
tweeter = TweetCrawler.new
sender = Sender.new

i = 0

loop do
  i += 1
  puts "iteration #{i}"
  crawler.save_measurement
  processor.save_text("number-#{i}")
  tweeter.save_tweets
  sender.send_commands
  sleep 5
end
