require 'spec_helper'

describe "paragraphs/new" do
  before(:each) do
    assign(:paragraph, stub_model(Paragraph,
      :language => 1,
      :content => "MyString",
      :article_id => 1
    ).as_new_record)
  end

  it "renders new paragraph form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", paragraphs_path, "post" do
      assert_select "input#paragraph_language[name=?]", "paragraph[language]"
      assert_select "input#paragraph_content[name=?]", "paragraph[content]"
      assert_select "input#paragraph_article_id[name=?]", "paragraph[article_id]"
    end
  end
end
