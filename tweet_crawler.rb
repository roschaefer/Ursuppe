require './connection'

class TweetCrawler
  QUERY = "#ursuppe"
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.access_token        = secrets['access_token']
      config.access_token_secret = secrets['access_token_secret']
      config.consumer_key        = secrets['consumer_key']
      config.consumer_secret     = secrets['consumer_secret']
    end
  end

  def secrets
    @secrets ||= YAML::load_file('secrets.yml')
    @secrets["twitter"]
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





