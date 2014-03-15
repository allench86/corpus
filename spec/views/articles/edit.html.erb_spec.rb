require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :doc_id => "MyString",
      :speech_id => "MyString",
      :speech_title => "MyString",
      :speaker => "MyString",
      :gender => "MyString",
      :title_of_speaker => "MyString",
      :event => "MyString",
      :topic => "MyString",
      :word_count => 1,
      :difficulty_level => "MyString",
      :text_features => "MyString",
      :chinese_paragraph_num => 1,
      :english_paragraph_num => 1,
      :last_editor_id => 1
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_doc_id[name=?]", "article[doc_id]"
      assert_select "input#article_speech_id[name=?]", "article[speech_id]"
      assert_select "input#article_speech_title[name=?]", "article[speech_title]"
      assert_select "input#article_speaker[name=?]", "article[speaker]"
      assert_select "input#article_gender[name=?]", "article[gender]"
      assert_select "input#article_title_of_speaker[name=?]", "article[title_of_speaker]"
      assert_select "input#article_event[name=?]", "article[event]"
      assert_select "input#article_topic[name=?]", "article[topic]"
      assert_select "input#article_word_count[name=?]", "article[word_count]"
      assert_select "input#article_difficulty_level[name=?]", "article[difficulty_level]"
      assert_select "input#article_text_features[name=?]", "article[text_features]"
      assert_select "input#article_chinese_paragraph_num[name=?]", "article[chinese_paragraph_num]"
      assert_select "input#article_english_paragraph_num[name=?]", "article[english_paragraph_num]"
      assert_select "input#article_last_editor_id[name=?]", "article[last_editor_id]"
    end
  end
end
