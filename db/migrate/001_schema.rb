class Schema < ActiveRecord::Migration
  def change
    create_table :templates, :id => false, :force => :true do |t|
      t.primary_key :Baustein_ID
    end
  end
end
