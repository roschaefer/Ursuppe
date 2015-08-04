class AddDoneToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :done, :boolean
  end
end
