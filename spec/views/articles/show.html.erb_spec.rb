require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Doc/)
    rendered.should match(/Speech/)
    rendered.should match(/Speech Title/)
    rendered.should match(/Speaker/)
    rendered.should match(/Gender/)
    rendered.should match(/Title Of Speaker/)
    rendered.should match(/Event/)
    rendered.should match(/Topic/)
    rendered.should match(/1/)
    rendered.should match(/Difficulty Level/)
    rendered.should match(/Text Features/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
