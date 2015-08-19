require 'active_record'
require 'sqlite3'
require 'logger'
require 'pry'
require 'ruby_spark'
require 'twitter'

require './ursuppe/models'
require './ursuppe/text_processor'
require './ursuppe/tweet_crawler'
require './ursuppe/spark'

module Ursuppe
  START_OF_EXPERIMENT = Time.new(2015, 8, 01)

  def self.day_of_experiment
    ((Time.now - Ursuppe::START_OF_EXPERIMENT)/1.day).to_i
  end

end
