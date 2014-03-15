class AddEnglishMetadataColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :english_metadata, :string
  end
end
