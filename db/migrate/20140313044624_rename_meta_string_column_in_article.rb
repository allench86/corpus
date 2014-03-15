class RenameMetaStringColumnInArticle < ActiveRecord::Migration
  def up
    rename_column :articles, :chinese_metadata, :chinese_metadata_string
    rename_column :articles, :english_metadata, :english_metadata_string
  end

  def down
  end
end
