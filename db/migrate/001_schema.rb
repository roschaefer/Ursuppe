class Schema < ActiveRecord::Migration
  def change
    create_table :templates, :id => false, :force => :true do |t|
      t.primary_key :Baustein_ID
      t.string :Baustein_Titel
      t.string :Baustein_Typ
      t.integer :Baustein_Prio
      t.integer :Baustein_von
      t.integer :Baustein_bis
      t.datetime :Baustein_Zeitvon
      t.datetime :Baustein_Zeitbis
      t.integer :Sensor_Nr
      t.integer :Sensor_Min
      t.integer :Sensor_Max
      t.integer :Min_vergangenseitmessung
      t.integer :zufallszahl_set
      t.integer :zufallszahl_position
      t.string :Baustein_Text
      t.string :Baustein_Vorspann
      t.string :Baustein_Abspann
      t.string :Baustein_Quelle
      t.string :bild_name
      t.string :bild_bu
      t.string :bild_credit
    end
  end
end
