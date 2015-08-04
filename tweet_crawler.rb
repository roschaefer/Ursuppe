require './connection'

class TweetCrawler
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.access_token = "1558870975-G7P8Cg6GP1CI64aKNKcGB7bNAODieeu7PEDryRl"
      config.access_token_secret = "J6rYortFGoQTgnVreaXyHylCwMS45TvUTDGcmo5FnDlSq"
      config.consumer_key = "AqmLdN6AAW0u7d5r1Xa3TD3Qs"
      config.consumer_secret = "rQGtRzfYTVkCL2jAIrBbdqBieaXJOXPFgMoysBPS9u1uXZeAzG"
    end
  end

  def save_tweets
    last_tweet = Tweet.order(:tweeted_at  => :desc).last
    query = "#ursuppe"
    query << " since:#{last_tweet.tweeted_at.strftime("%Y:%m:%d")}" if last_tweet
    tweets = @client.search(query)
    tweets.each do |tweet|
      t = Tweet.new( {
        :user => tweet.user.screen_name.to_s,
        :text => tweet.text.to_s,
        :location => tweet.user.location.to_s,
        :image => tweet.user.profile_image_uri_https.to_s,
        :tweeted_at => tweet.created_at
      })
      t.save
    end
  end
end




