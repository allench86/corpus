class RemoveColumnsFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :date
    remove_column :articles, :difficulty_level
    remove_column :articles, :doc_id
    remove_column :articles, :event
    remove_column :articles, :gender
    remove_column :articles, :speaker
  	remove_column :articles, :speech_id
  	remove_column :articles, :speech_title
  	remove_column :articles, :text_features
  	remove_column :articles, :title_of_speaker
  	remove_column :articles, :topic
  	remove_column :articles, :word_count
  end

  def down
    add_column :articles, :date, :string
    add_column :articles, :difficulty_level, :string
    add_column :articles, :doc_id, :string
    add_column :articles, :event, :string
    add_column :articles, :gender, :string
    add_column :articles, :speaker, :string
  	add_column :articles, :speech_id, :string
  	add_column :articles, :speech_title, :string
  	add_column :articles, :text_features, :string
  	add_column :articles, :title_of_speaker, :string
  	add_column :articles, :topic, :string
  	add_column :articles, :word_count, :string
  end
end
