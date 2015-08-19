RSpec.describe Ursuppe::TweetCrawler do
  describe "::new" do
    it "can be initialized" do
      described_class.new
    end
  end

  describe "#secrets" do
    specify { expect(subject.secrets['access_token']).not_to eq "ACCESS_TOKEN" }
    specify { expect(subject.secrets['access_token_secret']).not_to eq "ACCESS_TOKEN_SECRET" }
    specify { expect(subject.secrets['consumer_key']).not_to eq "CONSUMER_KEY" }
    specify { expect(subject.secrets['consumer_secret']).not_to eq "CONSUMER_SECRET" }
  end

  context "remote calls", :vcr => true do
    describe "#tweets" do
      context "this weeks tweets for hashtag #ursuppe" do
        specify{ expect(subject.tweets.entries).not_to be_empty }
        specify{ expect(subject.tweets.first.text).to include("#ursuppe") }
      end
    end

    describe "#save_tweets" do
      specify{expect(Ursuppe::Tweet.all).to be_empty}
      specify{expect{subject.save_tweets}.to change{Ursuppe::Tweet.count}.from(0).to(1)}
    end
  end
end
