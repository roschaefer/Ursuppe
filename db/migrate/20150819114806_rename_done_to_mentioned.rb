class RenameDoneToMentioned < ActiveRecord::Migration
  def change
    rename_column :tweets, :done, :mentioned
    change_column :tweets, :mentioned, :type, default: false
  end
end
