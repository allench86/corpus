require 'spec_helper'

describe Paragraph do
  include ArticlesHelper

  let(:user) { FactoryGirl.create(:user) }
  let(:paragraph1) { "Paragraph1" }
  let(:paragraph2) { "Paragraph2" }
  let(:article)    { user.articles.build(last_editor_id: user.id) }

  it "can create paragraphes" do
    article.paragraphs.build(content: paragraph1, language: 1)
    article.paragraphs.build(content: paragraph2, language: 1)
  end

   describe "search" do

    context "search for an English word" do
      let(:keyword) {'keyword'}
      let(:chinese_article) {<<-eos
  {property1=属性1
property2=属性2}

  段落1
  段落2
eos
}

      let(:english_article) {<<-eos
  {property1=properpy1_value
property2=property2_value}

  paragraph1
  paragraph2 #{keyword}
eos
}
      it "should return the English paragraph contains the searched word" do
        searchable_article = create_article_under_current_user(user,
          chinese_article, english_article)
        searchable_article.save

        search = Paragraph.search do
          fulltext keyword
        end
        p search
        p search.results
        p search.results[0].article.english_paragraphs.index(search.results[0])
      end
    end
  end
end
