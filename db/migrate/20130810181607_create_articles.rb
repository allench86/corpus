class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :doc_id
      t.string :speech_id
      t.string :speech_title
      t.string :speaker
      t.string :gender
      t.string :title_of_speaker
      t.date :date
      t.string :event
      t.string :topic
      t.integer :word_count
      t.string :difficulty_level
      t.string :text_features
      t.integer :last_editor_id

      t.timestamps
    end
  end
end
