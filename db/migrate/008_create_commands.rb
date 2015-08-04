class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands, :force => true do |t|
      t.string :name
      t.integer :tweet_id
      t.boolean :done
    end
  end
end
