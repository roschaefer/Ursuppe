class AddDefaultValueToTextComponents < ActiveRecord::Migration
  def change
    change_column :text_components, :Baustein_Typ, :type, default: "text"
  end
end
