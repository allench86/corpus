require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :doc_id => "Doc",
        :speech_id => "Speech",
        :speech_title => "Speech Title",
        :speaker => "Speaker",
        :gender => "Gender",
        :title_of_speaker => "Title Of Speaker",
        :event => "Event",
        :topic => "Topic",
        :word_count => 1,
        :difficulty_level => "Difficulty Level",
        :text_features => "Text Features",
        :chinese_paragraph_num => 2,
        :english_paragraph_num => 3,
        :last_editor_id => 4
      ),
      stub_model(Article,
        :doc_id => "Doc",
        :speech_id => "Speech",
        :speech_title => "Speech Title",
        :speaker => "Speaker",
        :gender => "Gender",
        :title_of_speaker => "Title Of Speaker",
        :event => "Event",
        :topic => "Topic",
        :word_count => 1,
        :difficulty_level => "Difficulty Level",
        :text_features => "Text Features",
        :chinese_paragraph_num => 2,
        :english_paragraph_num => 3,
        :last_editor_id => 4
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Doc".to_s, :count => 2
    assert_select "tr>td", :text => "Speech".to_s, :count => 2
    assert_select "tr>td", :text => "Speech Title".to_s, :count => 2
    assert_select "tr>td", :text => "Speaker".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Title Of Speaker".to_s, :count => 2
    assert_select "tr>td", :text => "Event".to_s, :count => 2
    assert_select "tr>td", :text => "Topic".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Difficulty Level".to_s, :count => 2
    assert_select "tr>td", :text => "Text Features".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
