class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.integer :language
      t.string :content
      t.integer :article_id

      t.timestamps
    end
  end
end
