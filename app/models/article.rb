class Article < ActiveRecord::Base
  include ArticlesHelper

  attr_accessible  :last_editor_id, :chinese_metadata_string, :english_metadata_string
  validates :user_id, presence: true
  has_many :paragraphs, dependent: :destroy
  belongs_to :user
  validates :last_editor_id, presence: true
  default_scope order: 'articles.created_at DESC'

  def chinese_article
  	content = chinese_metadata_string
  	chinese_paragraphs = paragraphs.find_all_by_language(1)
  	content = "#{content}\n" + chinese_paragraphs.map! { |paragraph| "#{paragraph.content}" }.join("\n")
  end

  def chinese_paragraphs
  	paragraphs.find_all_by_language(1)
  end

  def chinese_metadata
    extract_metadata(chinese_metadata_string)
  end

  def english_metadata
    extract_metadata(english_metadata_string)
  end

  def english_article
  	content = english_metadata_string
  	english_paragraphs = paragraphs.find_all_by_language(2)
  	content = "#{content}\n" + english_paragraphs.map! { |paragraph| "#{paragraph.content}" }.join("\n")
  end

  def english_paragraphs
  	paragraphs.find_all_by_language(2)
  end
end
