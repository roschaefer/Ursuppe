class RenameColumnDoneToExecuted < ActiveRecord::Migration
  def change
    rename_column :commands, :done, :executed
  end
end
