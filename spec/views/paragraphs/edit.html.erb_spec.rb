require 'spec_helper'

describe "paragraphs/edit" do
  before(:each) do
    @paragraph = assign(:paragraph, stub_model(Paragraph,
      :language => 1,
      :content => "MyString",
      :article_id => 1
    ))
  end

  it "renders the edit paragraph form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paragraph_path(@paragraph), "post" do
      assert_select "input#paragraph_language[name=?]", "paragraph[language]"
      assert_select "input#paragraph_content[name=?]", "paragraph[content]"
      assert_select "input#paragraph_article_id[name=?]", "paragraph[article_id]"
    end
  end
end
