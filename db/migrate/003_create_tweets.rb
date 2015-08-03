class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, :force => :true do |t|
      t.string :user
      t.text :text
      t.string :location
      t.string :image
    end
  end
end
