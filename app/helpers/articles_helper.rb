require 'java'

java_import java.util.Properties
java_import java.io.StringReader
#java_import java.util.Set

module ArticlesHelper

  def extract_metadata_string(article)
    if (! article.blank?)
      index_of_left_brace = article.index('{');
      index_of_right_brace = article.index('}');

      if index_of_left_brace.nil? || index_of_right_brace.nil?
        raise 'Can\'t find metadata block'
      end

      metadata_string = article[index_of_left_brace..index_of_right_brace]

      return metadata_string
    else
      raise 'Can\'t parse empty article'
    end
  end

  def extract_metadata(article)
    if (! article.blank?)
      index_of_left_brace = article.index('{');
      index_of_right_brace = article.index('}');

      if index_of_left_brace.nil? || index_of_right_brace.nil?
        raise 'Can\'t find metadata block'
      end

      metadata_string = article[index_of_left_brace+1..index_of_right_brace-1]
      metadata_string_reader = StringReader.new(metadata_string)

      properties = Properties.new
      properties.load(metadata_string_reader)
      property_set = properties.entrySet()

      metadata = Hash.new

      property_set.each do |entry|
        metadata[entry.getKey] = entry.getValue
      end
      return metadata
    else
      raise 'Can\'t parse empty article'
    end
  end

  def extract_paragraphes(article, paragraph_split_patten)
    if (! article.blank?)
      content = get_article_content(article)
      paragraphes = []
      content.split(paragraph_split_patten).each do |paragraph|
        if ! paragraph.try(:strip).blank?
          paragraphes << paragraph.try(:strip)
        end
      end
      return paragraphes
    else
      raise 'Can\'t parse empty article'
    end
  end

  def create_article_under_current_user(current_user, chinese_article, english_article)
    chinese_metadata_string = extract_metadata_string(chinese_article)
    english_metadata_string = extract_metadata_string(english_article)

    chinese_paragraphs = extract_paragraphes(chinese_article, "\n")
    english_paragraphs = extract_paragraphes(english_article, "\n")

    article = current_user.articles.build(
      chinese_metadata_string: chinese_metadata_string,
      english_metadata_string: english_metadata_string,
      last_editor_id: current_user.id)

    chinese_paragraphs.each do |chinese_paragraph|
      article.paragraphs.build(content: chinese_paragraph, language: 1)
    end

    english_paragraphs.each do |english_paragraph|
      article.paragraphs.build(content: english_paragraph, language: 2)
    end

    return article
  end

  private
    def get_article_content(article)
      if (! article.blank?)
        index_of_right_brace = article.index('}');

        if index_of_right_brace.nil?
          return article
        else
          return article[index_of_right_brace+1..-1]
        end
      else
        raise 'Can\'t parse empty article'
      end
    end
end
