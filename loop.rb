require './connection'
require './crawler'
crawler = Crawler.new

i = 0

loop do
  i += 1
  puts "iteration #{i}"
  crawler.save_measurement
  sleep 5
end
