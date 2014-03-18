class Paragraph < ActiveRecord::Base
  attr_accessible :content, :language
  belongs_to :article

  searchable do
    text :content
  end

  def self.search_for(keyword, page)
    if keyword.present?
      return search do
        fulltext keyword
        paginate :page => page, :per_page => 10
      end
    end
    nil
  end
end
