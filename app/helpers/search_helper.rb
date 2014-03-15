module SearchHelper
  def do_search(keyword, current_page)
    solr_search_obj_of_paragraph = Paragraph.search_for(keyword, current_page)
    MySearchResults.new(keyword, current_page, solr_search_obj_of_paragraph)
  end

  private

  class MySearchResults
    cattr_accessor :search, :total, :result_set, :keyword, :current_page

    def initialize(keyword, current_page, search)
      self.search = search
      self.total = search.total
      self.keyword = keyword
      self.current_page = current_page
      self.result_set = []
      result = {}
      search.results.each do |paragraph|
        result[:article] = paragraph.article
        result[:chinese_paragraph] = get_chinese_paragraph(paragraph)
        result[:english_paragraph] = get_english_paragraph(paragraph)
        self.result_set.push(result)
      end
    end

    # def current_page
    #   self.current_page
    # end

    def total_pages
      self.search.results.total_pages
    end

    def first_page?
      self.search.results.first_page?
    end

    def last_page?
      self.search.results.last_page?
    end

    def previous_page
      self.search.results.previous_page
    end

    def next_page
      self.search.results.next_page
    end

    def out_of_bounds?
      self.search.results.out_of_bounds?
    end

    def offset
      self.search.results.offset
    end

    private
    def get_chinese_paragraph(paragraph)
      if paragraph.language == 1
        return paragraph
      elsif paragraph.language == 2
        english_paragraphs = paragraph.article.english_paragraphs
        chinese_paragraphs = paragraph.article.chinese_paragraphs
        english_paragraph_index = english_paragraphs.index(paragraph)
        if english_paragraph_index < chinese_paragraphs.size
          p chinese_paragraphs[english_paragraph_index]
          return chinese_paragraphs[english_paragraph_index]
        end
      end
      nil
    end

    def get_english_paragraph(paragraph)
      if paragraph.language == 2
        return paragraph
      elsif paragraph.language == 1
        english_paragraphs = paragraph.article.english_paragraphs
        chinese_paragraphs = paragraph.article.chinese_paragraphs
        chinese_paragraph_index = chinese_paragraphs.index(paragraph)
        if chinese_paragraph_index < english_paragraphs.size
          return english_paragraphs[chinese_paragraph_index]
        end
      end
      nil
    end
  end
end
