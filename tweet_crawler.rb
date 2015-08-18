require './connection'

class TweetCrawler
  QUERY = "#ursuppe"
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.access_token = "1558870975-G7P8Cg6GP1CI64aKNKcGB7bNAODieeu7PEDryRl"
      config.access_token_secret = "J6rYortFGoQTgnVreaXyHylCwMS45TvUTDGcmo5FnDlSq"
      config.consumer_key = "AqmLdN6AAW0u7d5r1Xa3TD3Qs"
      config.consumer_secret = "rQGtRzfYTVkCL2jAIrBbdqBieaXJOXPFgMoysBPS9u1uXZeAzG"
    end
  end


  def tweets
    @client.search(QUERY)
  end

  def save_tweets
    tweets.each do |tweet|
      t = Tweet.new( {
        :twitter_id => tweet.id,
        :user => tweet.user.screen_name.to_s,
        :text => tweet.text.to_s,
        :location => tweet.user.location.to_s,
        :image => tweet.user.profile_image_uri_https.to_s,
        :tweeted_at => tweet.created_at
      })
      unless t.save
        # duplicate tweet
      end
    end
  end
end





