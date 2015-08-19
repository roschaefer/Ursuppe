class AddDescriptionAndParametersToCommands < ActiveRecord::Migration
  def change
    rename_column :commands, :name, :function
    add_column :commands, :parameter,   :string
    add_column :commands, :description, :string
  end
end
