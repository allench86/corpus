class AddChineseMetadataColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :chinese_metadata, :string
  end
end
