class RenameTemplatesToTextComponents < ActiveRecord::Migration
  def change
    rename_table :templates, :text_components
  end
end
