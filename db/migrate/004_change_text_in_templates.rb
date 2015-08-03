class ChangeTextInTemplates < ActiveRecord::Migration
  def change
    change_column :templates, :Baustein_Text, :text
  end
end
