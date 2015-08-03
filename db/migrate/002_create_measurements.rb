class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements, :force => true do |t|
      t.integer :movement_ground
      t.integer :light
      t.integer :temperature
    end
  end
end
