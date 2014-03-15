require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ArticlesHelper do
  let(:no_metadata_article) {"This is an article without metadata."}
  let(:empty_article) {""}
  let(:no_content_article) {<<-eos
  {property1=properpy1_value
property2=property2_value}
eos
}
  let(:valid_article) {<<-eos
  {property1=properpy1_value
property2=property2_value}

   This is first paragraph.
   This is second paragraph.
eos
}

  context 'When parsing a valid article' do
    it 'should extract metadata string' do
      valid_metadata_string = "{property1=properpy1_value\nproperty2=property2_value}"
      extract_metadata_string(valid_article).should eql valid_metadata_string
    end

    it 'should extract metadata' do
      valid_metadata = {'property1' => 'properpy1_value', 'property2' => 'property2_value'}
      extract_metadata(valid_article).should eql valid_metadata
    end

    it 'should extract paragraphes' do
      expected_paragraphes = ['This is first paragraph.', 'This is second paragraph.']
      extract_paragraphes(valid_article, "\n").should eql expected_paragraphes
    end

    context 'using wrong paragraph split patten' do
      it 'should return the whole content' do
        content = ["This is first paragraph.\n   This is second paragraph."]
        extract_paragraphes(valid_article, "<br>").should eql content
      end
    end
  end

  context 'When parsing an invalid artile' do
    context 'without metadata and content' do
      it 'should raise an exception' do
        expect { extract_metadata(empty_article) }.to raise_error("Can\'t parse empty article")
      end
    end

    context 'without metadata block' do
      it 'should raise an exception' do
        expect { extract_metadata(no_metadata_article) }.to raise_error("Can\'t find metadata block")
      end
    end

    context 'without content' do
      it 'should return empty array' do
        extract_paragraphes(no_content_article, "\n").should eql []
      end
    end
  end

  describe "create_article_under_current_user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @expected_article = user.articles.build(last_editor_id: user.id)

      chinese_metadata_string = "{property1=属性1\nproperty2=属性2}"
      english_metadata_string = "{property1=properpy1_value\nproperty2=property2_value}"

      chinese_paragraphs = ['段落1', '段落2']
      english_paragraphs = ['paragraph1', 'paragraph2']

      @expected_article = user.articles.build(
        chinese_metadata_string: chinese_metadata_string,
        english_metadata_string: english_metadata_string,
        last_editor_id: user.id)

      chinese_paragraphs.each do |chinese_paragraph|
        @expected_article.paragraphs.build(content: chinese_paragraph, language: 1)
      end

      english_paragraphs.each do |english_paragraph|
        @expected_article.paragraphs.build(content: english_paragraph, language: 2)
      end
    end

    context 'When parsing a valid article' do
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
  paragraph2
eos
}

      it 'should return an article object' do
        article = create_article_under_current_user(user,
          chinese_article, english_article)

        article.chinese_metadata_string.should eql @expected_article.chinese_metadata_string
        article.english_metadata_string.should eql @expected_article.english_metadata_string
        article.chinese_metadata.should eql @expected_article.chinese_metadata
        article.english_metadata.should eql @expected_article.english_metadata
        article.chinese_paragraphs.should eql @expected_article.chinese_paragraphs
        article.english_paragraphs.should eql @expected_article.english_paragraphs
        article.user_id.should eql @expected_article.user_id
        article.last_editor_id.should eql @expected_article.last_editor_id
      end
    end
  end
end
